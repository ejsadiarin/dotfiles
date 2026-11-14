# Does OpenWhisper have a cold start on the first transcription?

## Summary

**Yes.** Multiple Whisper-based local dictation apps — including both projects that go by
"OpenWhisper"/"OpenWhispr" — have a measurable cold-start penalty on the first
speech-to-text transcription after startup. The mechanism is model/weights load into
RAM or VRAM, GPU context (CUDA/Metal/Vulkan) initialization, and on some engines
one-time JIT/kernel compilation. Later transcriptions reuse the already-loaded model
and are fast.

The two most likely referents:

| Name | Repo | Engine |
| --- | --- | --- |
| OpenWhispr (most stars, ~9.1k) | https://github.com/OpenWhispr/openwhispr | whisper.cpp `whisper-server` subprocess, sherpa-onnx (Parakeet) |
| OpenWhisper (exact name match) | https://github.com/Knuckles92/OpenWhisper | faster-whisper (CTranslate2), various local engines |

## Evidence: OpenWhispr

- Its own docs state the cold start was a known problem and is mitigated by pre-warming:
  "OpenWhispr pre-warms the whisper-server process on startup to eliminate 2-5s
  cold-start delays" — https://mintlify.wiki/OpenWhispr/openwhispr/api/whisper-models
- CHANGELOG entries confirm it:
  - "Whisper Server Pre-warming: Server pre-warms on startup for faster first transcription"
  - "ONNX Warm-up Inference: Parakeet server now runs warm-up inference on start to
    eliminate first-request latency from JIT compilation"
  - "Local llama-server pre-warming restored. The local LLM server warms up ahead of
    time again, so the first local reasoning request isn't slow."
  - https://github.com/OpenWhispr/openwhispr/blob/main/CHANGELOG.md
- Source code (authoritative): `WhisperManager.initializeAtStartup()` in
  `src/helpers/whisper.js` starts the whisper-server subprocess at app startup with a
  comment "// Pre-warm whisper-server if local mode enabled (eliminates 2-5s
  cold-start delay)". If pre-warm fails or is skipped (model not downloaded, local
  mode off, binary missing), the log line is "Server pre-warm failed (will start on
  first use)" — i.e., the cost then lands on the first transcription instead.
  - https://github.com/OpenWhispr/openwhispr/blob/main/src/helpers/whisper.js
- A real-world log shows what the cold cost looks like without pre-warm: whisper-server
  takes ~4.2 s just to boot and load `ggml-medium.bin` before the first transcription
  can run —
  https://github.com/OpenWhispr/openwhispr/issues/126
- GPU-backend bugs can make the *first* request crash or fall back to CPU
  (the server then restarts on CPU and the first dictation pays the reload):
  https://github.com/OpenWhispr/openwhispr/issues/712
- Related third-party symptom with the same engine: first transcription of a session
  takes minutes while whisper-server loads the model and initializes the Vulkan
  backend; warm runs are ~6.5 s — https://github.com/getopenscreen/openscreen/issues/334

## Evidence: OpenWhispr runtime design (why it's cold by default)

`whisper-server` loads the GGML model into memory/VRAM when the subprocess starts, so
keeping the server alive between requests is what makes subsequent transcriptions
fast. Pre-warming moves that fixed cost from "first dictation" to "app startup".
If the server is not running (failed pre-warm, CLI fallback, model switch, restart
after GPU-pack change), the first transcription pays the startup cost again.

## Evidence: OpenWhisper (Knuckles92)

- GPU docs mention "cold start dropped from ~113 s to ~27 s" after fixing a compute-type
  fallback on older GPUs — direct acknowledgment that first model load is a large,
  real cost: https://github.com/Knuckles92/OpenWhisper#gpu-acceleration
- Local Whisper is powered by faster-whisper, whose model load happens on first use;
  one-time CTranslate2/CUDA initialization then dominates: see faster-whisper issue —
  https://github.com/SYSTRAN/faster-whisper/issues/396
  ("The first call always takes more time, but we are talking a few hundred milliseconds
  here" once the model is loaded; the multi-second cost is process/model startup.)

## Evidence: upstream Whisper / whisper.cpp (general mechanism)

- OpenAI Whisper CLI: every invocation is a fresh process; model load (incl. SHA256
  check) plus CUDA runtime init means the first transcription in a new process is
  slow; mitigations are reusing `load_model()` or running an API server —
  https://github.com/openai/whisper/discussions/669
- faster-whisper startup breakdown (torch-free, CTranslate2 init ~9 s + first
  transcribe ~6-8 s on older hardware): https://github.com/SYSTRAN/faster-whisper/issues/396

## Cause, concisely

1. Model weights load from disk into RAM/VRAM (one-time, per model and process).
2. GPU runtime init: CUDA context, Metal backend, or Vulkan pipeline (incl. cold
   shader-cache compile).
3. On some backends, one-time kernel/JIT compilation (Parakeet/ONNX: "first-request
   latency from JIT compilation").
4. VAD model (silero) load when VAD is enabled.

## Mitigations (used in practice)

- Pre-warm at app startup: spawn `whisper-server` (or ONNX/Parakeet warm-up inference,
  or a dummy `transcribe` call) before the user dictates — OpenWhispr does exactly
  this (`initializeAtStartup`, "ONNX Warm-up Inference").
- Keep the server process resident across requests instead of shelling out per
  transcription.
- For CLI/scripts: load the model once and reuse it, or run a server; `whisper` CLI
  has no persistent mode, so each run reloads.
- Pre-download models so the first run isn't also a network fetch.
- Use a compute type compatible with the GPU (e.g. float16 on modern NVIDIA, int8
  fallback on Pascal) to avoid pathological first-load memory pressure.

## Conclusion

Yes - a cold start on the first transcription after startup is expected behavior for
OpenWhispr/OpenWhisper-class local Whisper deployments. It is caused by one-time model
load, GPU context init, and JIT/kernel compilation, not by per-request overhead. The
projects mitigate it with explicit pre-warming at startup; if pre-warm is skipped or
fails, the first real transcription absorbs the cost (typically ~2–5 s for server boot
+ model load, worse on CPU/Pascal GPUs or Vulkan cold caches). Subsequent
transcriptions are fast because the server/model stays resident.
