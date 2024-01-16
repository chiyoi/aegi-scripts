script_name = 'Copy Time'
script_description = 'Copy start and end time to #selected_lines + 1 after.'
script_author = 'chiyoi'
script_version = '0.0'

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        for _, i in ipairs(selected_lines) do
            local index_after = i + #selected_lines + 1
            local line_after = subtitles[index_after]
            line_after.start_time = subtitles[i].start_time
            line_after.end_time = subtitles[i].end_time
            subtitles[index_after] = line_after
        end
    end
)
