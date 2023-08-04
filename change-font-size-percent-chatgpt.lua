-- This script adjusts the font size of selected lines in Aegisub

-- Adjust the font size of selected lines
function adjust_font_size(subtitles, selected_lines, delta)
    for _, line_index in ipairs(selected_lines) do
        local line = subtitles[line_index]
        local start, endpos, fs_tag = line.text:find("\\fs(%d+)")
        if fs_tag then
            local current_font_size = tonumber(fs_tag)
            local new_font_size = current_font_size + (current_font_size * delta / 100)
            local new_line_text = line.text:sub(1, start - 1) .. "\\fs" .. new_font_size .. line.text:sub(endpos + 1)
            line.text = new_line_text -- Update the 'text' property of the line
            subtitles[line_index] = line -- Store the updated line back in the 'subtitles' table
        end
    end
end

-- Function to create and display the GUI for adjusting the font size
function create_gui(subtitles, selected_lines)
    local config = {
        {
            class = "label",
            label = "Adjust Font Size by Percentage",
            x = 0,
            y = 0,
            width = 1,
            height = 1
        },
        {
            class = "intedit",
            name = "delta",
            value = 0, -- Default delta set to 0
            x = 1,
            y = 0,
            width = 1,
            height = 1
        }
    }

    local buttons = { "OK", "Cancel" }
    local button, result = aegisub.dialog.display(config, buttons)

    if button == "OK" then
        local delta = result.delta
        adjust_font_size(subtitles, selected_lines, delta)
        aegisub.set_undo_point("Adjust Font Size") -- Set undo point for the script
    end
end

-- Main function executed when the macro is run
function main(subtitles, selected_lines)
    -- Check if any lines are selected
    if #selected_lines == 0 then
        aegisub.debug.out("No lines selected.")
        return
    end

    -- Display the GUI to adjust the font size
    create_gui(subtitles, selected_lines)
end

-- Register the macro with Aegisub
aegisub.register_macro("Adjust Font Size (Percent)", "Adjusts the font size by percentage of selected lines", main)
