---@return function string
local getPasswordFactory = function()
  local bufferPasswordMap = {}

  return function()
    local key = string.format("%s", vim.fn.bufnr())
    if bufferPasswordMap[key] == nil then
      password = vim.fn.inputsecret("Enter password: ")
      bufferPasswordMap[key] = password
    end
    return bufferPasswordMap[key]
  end
end

local getPassword = getPasswordFactory()
local ENCRYPTED_PREFIX = "# <<<encrypted>>>"

---@enum buftype
local BUFTYPE = {
  encrypted = 1,
  plaintext = 2,
}

return { getPassword = getPassword, ENCRYPTED_PREFIX = ENCRYPTED_PREFIX, BUFTYPE = BUFTYPE}
