script_name = 'Lead In Out'
script_description = 'Add lead in/out time to each line.'
script_author = 'chiyoi'
script_version = '0.1'

local lead_in_time = 150
local lead_out_time = 120

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        for _, i in ipairs(selected_lines) do
            local line = subtitles[i]
            line.start_time = line.start_time - lead_in_time
            line.end_time = line.end_time + lead_out_time
            subtitles[i] = line
        end
    end
)
