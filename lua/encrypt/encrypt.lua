local helpers = require("encrypt.helpers")

---@return string[]
---@param lines string | string[]
---@param password string
local function encrypt_lines(lines, password)
  return vim.fn.systemlist(
    "openssl enc -aes-256-cbc -pbkdf2 -salt -in - -out - -k " .. password .. " | base64",
    lines
  )
end

local function encrypt()
  local password = helpers.getPassword()
  local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local encrypted_lines = encrypt_lines(buf_lines, password)

  table.insert(encrypted_lines, 1, helpers.ENCRYPTED_PREFIX)

  vim.fn.writefile(encrypted_lines, vim.fn.expand("%"))
  vim.bo.modified = false
  print("Encrypted " .. vim.fn.expand("%:t"))
end

return encrypt
