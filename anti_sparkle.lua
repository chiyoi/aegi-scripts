script_name = 'Anti-Sparkle'
script_description = 'Extend lines with end time close to the next line to avoid sparkle.'
script_author = 'chiyoi'
script_version = '0.0'

local threshold = 170

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        local process = function(lines)
            for i, line_index in ipairs(lines) do
                if i + 1 > #lines then return end
                local this_line = subtitles[line_index]
                local next_line = subtitles[lines[i + 1]]
                if next_line.start_time - this_line.end_time < threshold then
                    this_line.end_time = next_line.start_time
                end
                subtitles[line_index] = this_line
            end
        end
        local tops, subs = SplitListByCondition(selected_lines, function(line_index)
            return string.sub(subtitles[line_index].style, 1, 3) == "Top"
        end)
        process(tops)
        process(subs)
    end
)

-- Generated with GPT-4.
function SplitListByCondition(list, conditionFunc)
    local list1 = {}
    local list2 = {}

    for _, item in ipairs(list) do
        if conditionFunc(item) then
            table.insert(list1, item)
        else
            table.insert(list2, item)
        end
    end

    return list1, list2
end
