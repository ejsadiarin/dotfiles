# shellcheck shell=bash
# Shared helpers for install-skills-opencode and install-skills-mcp-claude.
# Source it; don't run it. Callers set SKILLS_NAME (log prefix) first.
#
# Third-party skill repos are shallow-cloned once into DATA_ROOT and shared
# by both scripts; each script links skills into its own tool's directory.

DATA_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles-skills"

FORCE=0
UPDATE=0
linked=0
failed=0

log() { printf '[%s] %s\n' "${SKILLS_NAME:-skills}" "$*"; }
warn() { printf '[%s] warning: %s\n' "${SKILLS_NAME:-skills}" "$*" >&2; }

# Parse --force / --update / --help. $1 = number of header lines to print as help.
parse_skill_args() {
  local help_lines="$1"
  shift
  while (($#)); do
    case "$1" in
      -f | --force) FORCE=1 ;;
      -u | --update) UPDATE=1 ;;
      -h | --help)
        sed -n "2,${help_lines}p" "$0" | sed 's/^# \{0,1\}//'
        exit 0
        ;;
      *)
        printf 'unknown option: %s\n\n' "$1" >&2
        sed -n "2,${help_lines}p" "$0" | sed 's/^# \{0,1\}//' >&2
        exit 2
        ;;
    esac
    shift
  done
  command -v git >/dev/null 2>&1 || {
    printf 'git is required\n' >&2
    exit 1
  }
  mkdir -p "$DATA_ROOT"
}

# Clone (or with --update, refresh) repo@ref into its cache dir; prints the dir.
sync_repo() {
  local repo="$1" ref="$2" cache url

  cache="$DATA_ROOT/${repo//\//__}@${ref//\//_}"
  url="https://github.com/$repo.git"

  if [[ ! -d "$cache/.git" ]]; then
    log "cloning $repo@$ref" >&2
    rm -rf "$cache"
    mkdir -p "$cache"
    git -C "$cache" init --quiet
    git -C "$cache" remote add origin "$url"
    if ! git -C "$cache" fetch --quiet --depth 1 origin "$ref"; then
      warn "could not fetch $ref for $repo"
      rm -rf "$cache"
      return 1
    fi
    git -C "$cache" -c advice.detachedHead=false checkout --quiet -B skills FETCH_HEAD
  elif ((UPDATE)); then
    log "updating $repo@$ref" >&2
    if git -C "$cache" fetch --quiet --depth 1 origin "$ref"; then
      git -C "$cache" -c advice.detachedHead=false checkout --quiet -B skills FETCH_HEAD
    else
      warn "could not fetch $ref for $repo; using the existing checkout"
    fi
  fi
  printf '%s\n' "$cache"
}

# Find the skill directory whose SKILL.md declares `name: <wanted>`.
# The shortest matching path wins, so current skills beat archived copies.
find_skill_dir() {
  local root="$1" wanted="$2" file name

  find "$root" \
    -type f -name SKILL.md \
    -not -path '*/.git/*' \
    -not -path '*/.agents/*' \
    -not -path '*/.claude/*' \
    -not -path '*/.claude-plugin/*' \
    -not -path '*/node_modules/*' \
    -not -path '*/deprecated/*' \
    -print0 |
    while IFS= read -r -d '' file; do
      name="$(awk 'NR <= 20 && /^name:/ { sub(/^name:[[:space:]]*/, ""); sub(/[[:space:]]+$/, ""); print; exit }' "$file" | tr -d "\"'\r")"
      if [[ "$name" == "$wanted" ]]; then
        printf '%s\n' "$(dirname "$file")"
      fi
    done |
    awk '{ if (best == "" || length($0) < length(best)) best = $0 } END { print best }'
}

# Link <dest_dir>/<name> -> <src>. Links this tooling made earlier (into
# DATA_ROOT, ~/.agents/skills or the dotfiles repo) are replaced; anything else
# is left alone unless --force, and real directories are moved aside, never deleted.
link_skill() {
  local src="$1" dest_dir="$2" name="$3" dest current resolved backup

  dest="$dest_dir/$name"
  mkdir -p "$dest_dir"

  if [[ -L "$dest" ]]; then
    current="$(readlink "$dest")"
    [[ "$current" == "$src" ]] && return 0

    resolved="$(readlink -f "$dest" 2>/dev/null || true)"
    case "$current|$resolved" in
      *"$DATA_ROOT"/* | *"$HOME/.agents/skills"/* | *../.agents/skills/* | *"$HOME/dotfiles"/*) rm -f "$dest" ;;
      *)
        if ((FORCE)); then
          rm -f "$dest"
        else
          warn "$dest points elsewhere ($current); leaving it (use --force to replace)"
          return 0
        fi
        ;;
    esac
  elif [[ -e "$dest" ]]; then
    if ((FORCE)); then
      backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
      mv "$dest" "$backup"
      log "moved existing $name to $backup"
    else
      warn "$dest already exists; leaving it (use --force to replace)"
      return 0
    fi
  fi

  ln -s "$src" "$dest"
}

# For each "repo|ref|skill skill ..." entry, clone and link into dest_dir.
install_sources() {
  local dest_dir="$1" entry repo ref skills cache name src
  shift

  for entry in "$@"; do
    IFS='|' read -r repo ref skills <<<"$entry"
    if ! cache="$(sync_repo "$repo" "$ref")"; then
      failed=$((failed + 1))
      continue
    fi
    for name in $skills; do
      src="$(find_skill_dir "$cache" "$name")"
      if [[ -z "$src" ]]; then
        warn "$repo@$ref does not contain a skill named '$name'"
        failed=$((failed + 1))
        continue
      fi
      link_skill "$src" "$dest_dir" "$name"
      [[ -L "$dest_dir/$name" ]] && linked=$((linked + 1))
    done
  done
}
