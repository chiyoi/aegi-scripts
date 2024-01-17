script_name = 'Lead In Out'
script_description = 'Add lead in/out time to each line.'
script_author = 'chiyoi'
script_version = '0.0'

local lead_in_time = 150
local lead_out_time = 120

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        for _, line_index in ipairs(selected_lines) do
            local line = subtitles[line_index]
            line.start_time = line.start_time - lead_in_time
            line.end_time = line.end_time + lead_out_time
            subtitles[line_index] = line
        end
    end
)
