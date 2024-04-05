-- -- get path
-- -- get frontmatter tag called "Created"
-- -- convert the tag to this format: %Y%m%d%H%M (in a new var)
-- -- prepend the var to the filename in path
--
-- local client = require("obsidian").get_client()
--
-- local scan = require("plenary.scandir")
-- local Note = require("obsidian.note")
-- -- local client = require("obsidian").get_client()
--
-- local paths = scan.scan_dir(tostring(client.dir), { search_pattern = ".*.md$" })
--
-- for _, path in ipairs(paths) do
-- 	print(string.format("Updating note at %s...", path))
-- 	local Created_tag = Note.get_field(path, "Created")
-- 	local formatted_date = os.date("%Y%m%d%H%M", Created_tag)
-- 	local note = Note.fname(path)
-- 	note:save()
-- end
--
-- -- like '202404041426-my-new-note', and therefore the file name '202404041426-my-new-note.md'
-- local suffix = "" -- TODO: filename of Journal notes here
--
-- -- client:apply_async(function(note)
-- -- 	print(string.format("Updating note %s...", note.path))
-- -- 	note:fname = formatted_date .. "-" .. suffix
-- -- 	note:save()
-- -- end)
--

local client = require("obsidian").get_client()
local scan = require("plenary.scandir")
local Note = require("obsidian.note")

local paths = scan.scan_dir(tostring(client.dir), { search_pattern = ".*.md$" })

for _, path in ipairs(paths) do
	print(string.format("Updating note at %s...", path))
	local created_tag = Note.get_field(path, "Created")
	if created_tag then
		local formatted_date = os.date("%Y%m%d%H%M", created_tag)
		local note = Note.path
		local new_filename = formatted_date .. "-" .. note.filename
		local new_path = note.cwd .. "/" .. new_filename .. ".md"
		os.rename(path, new_path)
		print(string.format("Note renamed to: %s", new_path))
	else
		print("Note does not have a 'Created' tag.")
	end
end
