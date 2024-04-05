-- NOTE:
-- needs obsidian.nvim to work
-- note:save() will write the frontmatter and leave the rest of the contents alone.
-- Then from a buffer in your vault (obsidian.nvim needs to be loaded), run :luafile tmp.lua.
-- ref: https://github.com/epwalsh/obsidian.nvim/discussions/335

local client = require("obsidian").get_client()

client:apply_async(function(note)
	print(string.format("Updating note %s...", note.path))
	note:save()
end)

-- WARNING: OLD VER before https://github.com/epwalsh/obsidian.nvim/pull/336 merges:

-- local scan = require("plenary.scandir")
-- local Note = require("obsidian.note")
-- local client = require("obsidian").get_client()

-- local paths = scan.scan_dir(tostring(client.dir), { search_pattern = ".*.md$" })
-- for _, path in ipairs(paths) do
-- 	print(string.format("Updating note at %s...", path))
-- 	local note = Note.from_file(path, client.dir)
-- 	note:save()
-- end
