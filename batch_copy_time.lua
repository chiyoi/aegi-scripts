script_name = 'Batch Copy Time'
script_description = 'Copy start time and end time to #selected_lines + 1 after.'
script_author = 'chiyoi'
script_version = '0.0'

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        for _, line_index in ipairs(selected_lines) do
            local index_after = line_index + #selected_lines + 1
            local line_after = subtitles[index_after]
            line_after.start_time = subtitles[line_index].start_time
            line_after.end_time = subtitles[line_index].end_time
            subtitles[index_after] = line_after
        end
    end
)
