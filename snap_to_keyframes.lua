script_name = 'Snap to Keyframes'
script_description = 'Snap to keyframes for each line.'
script_author = 'chiyoi'
script_version = '0.0'

local starts_before_threshold = 200
local starts_after_threshold = 100
local ends_before_threshold = 180
local ends_after_threshold = 250

aegisub.register_macro(
    script_name,
    script_description,
    function(subtitles, selected_lines, active_line)
        local keyframes = Keyframes()
        for _, line_index in ipairs(selected_lines) do
            local line = subtitles[line_index]
            local keyframe_timestamp = RoundToTens(Closest(keyframes, line.start_time))
            if
                line.start_time < keyframe_timestamp and keyframe_timestamp - line.start_time < starts_before_threshold or
                keyframe_timestamp < line.start_time and line.start_time - keyframe_timestamp < starts_after_threshold
            then
                line.start_time = keyframe_timestamp
            end
            keyframe_timestamp = RoundToTens(Closest(keyframes, line.end_time))
            if
                line.end_time < keyframe_timestamp and keyframe_timestamp - line.end_time < ends_before_threshold or
                keyframe_timestamp < line.end_time and line.end_time - keyframe_timestamp < ends_after_threshold
            then
                line.end_time = keyframe_timestamp
            end
            subtitles[line_index] = line
        end
    end
)

function Keyframes()
    local filename = os.getenv('HOME') .. '/Downloads/keyframes.txt'
    local file = io.open(filename, 'r')
    if file == nil then error('Could not open file: ' .. filename) end
    local keyframes = {}
    for line in file:lines() do
        local num = tonumber(line)
        if num then table.insert(keyframes, num) end
    end
    file:close()
    return keyframes
end

function RoundToTens(num)
    return math.floor(num / 10 + 0.5) * 10
end

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
