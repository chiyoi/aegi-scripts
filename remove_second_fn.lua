script_name = 'Remove Second FN'
script_description = 'Remove the second \\fn tag.'
script_author = 'chiyoi'
script_version = '0.0'

aegisub.register_macro(
  script_name,
  script_description,
  function(subtitles, selected_lines, active_line)
    for _, line_index in ipairs(selected_lines) do
      local line = subtitles[line_index]
      line.text = RemoveSecondFnSubstring(line.text)
      subtitles[line_index] = line
    end
  end
)

function RemoveSecondFnSubstring(input)
  local fnCount = 0
  local startPos, endPos

  -- Iterate through all occurrences of \fn in the string
  for pos in string.gmatch(input, "()\\fn") do
    fnCount = fnCount + 1
    if fnCount == 2 then -- When the second \fn is found
      startPos = pos
      break              -- Exit the loop as we've found the second occurrence
    end
  end

  if not startPos then
    return input -- Return the original string if \fn occurs less than twice
  end

  -- Find the next backslash after the second \fn
  endPos = string.find(input, "\\", startPos + 1)
  if not endPos then
    return string.sub(input, 1, startPos - 1) -- If no backslash is found after, remove from second \fn to the end
  end

  -- Concatenate the part before the second \fn and the part after the next backslash
  return string.sub(input, 1, startPos - 1) .. string.sub(input, endPos)
end
