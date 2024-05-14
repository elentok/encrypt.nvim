---@return string
local function getPassword()
  local password = vim.b["password"]
  if password == nil then
    password = vim.fn.inputsecret("Enter password: ")
    vim.b["password"] = password
  end
  return password
end

local ENCRYPTED_PREFIX = "# <<<encrypted>>>"

return { getPassword = getPassword, ENCRYPTED_PREFIX = ENCRYPTED_PREFIX }
