script_name = 'To Vertical'
script_description = 'Insert hard new lines to make line vertical.'
script_author = 'chiyoi'
script_version = '0.0'

aegisub.register_macro(
  script_name,
  script_description,
  function(subtitles, selected_lines, active_line)
    for _, line_index in ipairs(selected_lines) do
      local line = subtitles[line_index]
      line.text = AddSlashNOutsideBracketsUTF8(line.text)
      subtitles[line_index] = line
    end
  end
)

function AddSlashNOutsideBracketsUTF8(input)
  local unicode = require 'aegisub.unicode'
  local result = ""
  local inBrackets = false
  local previousWasClosingBracket = false
  local firstCharacter = true

  for char in unicode.chars(input) do
    if char == "{" then
      inBrackets = true
      previousWasClosingBracket = false
    elseif char == "}" then
      inBrackets = false
      previousWasClosingBracket = true
    end

    if not inBrackets and not previousWasClosingBracket and not firstCharacter then
      result = result .. "\\N" .. char
    else
      result = result .. char
    end

    if char ~= "}" then
      previousWasClosingBracket = false
    end
    firstCharacter = false
  end

  return result
end
