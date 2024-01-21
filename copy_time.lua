script_name = 'Copy Time'
script_description = 'Copy start time and end time below.'
script_author = 'chiyoi'
script_version = '0.0'

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        if #selected_lines ~= 1 then error('Select exactly one line.') end
        local line_index = selected_lines[1]
        local index_below = line_index + 1
        local line_below = subtitles[index_below]
        line_below.start_time = subtitles[line_index].start_time
        line_below.end_time = subtitles[line_index].end_time
        subtitles[index_below] = line_below
    end
)
