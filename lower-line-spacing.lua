-- Automation 5 demo script
-- Macro that adds line spacing in front of every selected line

local tr = aegisub.gettext

script_name = tr"Line Spacing -0.0005"
script_description = tr"Adds spacing to all selected lines"
script_author = "Max Deryagin"
script_version = "1"


function add_spacing(subtitles, selected_lines, active_line)
	for z, i in ipairs(selected_lines) do
		local l = subtitles[i]
           if string.match(l.text, "\\N") then
              l.text = "{\\org(-2000000,0)\\fr-0.0005}" .. l.text
		   l.text = string.gsub(l.text, "\\N", "{\\r}\\N",1)
		   subtitles[i] = l
           else
           end
	end
	aegisub.set_undo_point(script_name)
end

aegisub.register_macro(script_name, tr"Adds spacing to all selected lines", add_spacing)
