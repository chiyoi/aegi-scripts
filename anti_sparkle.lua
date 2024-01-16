script_name = 'Anti-Sparkle'
script_description = 'Extend lines with end time close to the next line to avoid sparkle.'
script_author = 'chiyoi'
script_version = '0.0'

local threshold = 200

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        for _, i in ipairs(selected_lines) do
            if i + 1 >= #selected_lines then return end
            local this_line = subtitles[i]
            local next_line = subtitles[i + 1]
            if next_line.start_time - this_line.end_time < threshold then
                this_line.end_time = next_line.start_time
            end
            subtitles[i] = this_line
        end
    end
)
