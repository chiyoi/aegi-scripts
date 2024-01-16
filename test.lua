script_name = 'Test'
script_description = 'Test'
script_author = 'chiyoi'
script_version = '0.1'

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        for _, i in ipairs(selected_lines) do
            local line = subtitles[i]
            local filename = os.getenv('HOME') .. '/Desktop/keyframes.txt'
            local file = io.open(filename, 'r')
            if file == nil then
                line.text = 'error'
            else
                line.text = filename
                file:close()
            end
            subtitles[i] = line
        end
    end
)
