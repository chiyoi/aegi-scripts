script_name = 'Stick to Keyframes'
script_description = 'Offset line start/end time if close to keyframes.'
script_author = 'chiyoi'
script_version = '0.0'

local start_forward_threshold = 80
local start_backward_threshold = 80
local end_forward_threshold = 80
local end_backward_threshold = 200

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        local filename = os.getenv('HOME') .. '/Downloads/keyframes.txt'
        local file = io.open(filename, 'r')
        if file == nil then error('Could not open file: ' .. filename) end
        local keyframes = {}
        for line in file:lines() do
            local num = tonumber(line)
            if num then table.insert(keyframes, num) end
        end
        for _, i in ipairs(selected_lines) do
            local line = subtitles[i]
            local keyframe_timestamp = Closest(keyframes, line.start_time)
            if
                line.start_time < keyframe_timestamp and keyframe_timestamp - line.start_time < start_forward_threshold or
                keyframe_timestamp < line.start_time and line.start_time - keyframe_timestamp < start_backward_threshold
            then
                line.start_time = keyframe_timestamp
            end
            keyframe_timestamp = Closest(keyframes, line.end_time)
            if
                line.end_time < keyframe_timestamp and keyframe_timestamp - line.end_time < end_forward_threshold or
                keyframe_timestamp < line.end_time and line.end_time - keyframe_timestamp < end_backward_threshold
            then
                line.end_time = keyframe_timestamp
            end
            subtitles[i] = line
        end
        file:close()
    end
)

-- Generated with GPT-4, modified.
function Closest(array, target)
    if #array == 0 then error('Empty array.') end -- Handle empty array
    if #array == 1 then return array[1] end       -- Handle single element array

    local left, right = 1, #array
    local mid, closest

    while left <= right do
        mid = math.floor((left + right) / 2)

        if array[mid] == target then
            return array[mid] -- Target found
        end

        -- Check if current mid element is closer than previous closest
        if closest == nil or math.abs(array[mid] - target) < math.abs(array[closest] - target) then
            closest = mid
        end

        if array[mid] < target then
            left = mid + 1
        else
            right = mid - 1
        end
    end

    return array[closest]
end
