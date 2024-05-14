local helpers = require("encrypt.helpers")

---@return string[]
---@param lines string | string[]
---@param password string
local function decrypt_lines(lines, password)
  return vim.fn.systemlist(
    "base64 --decode | openssl enc -d -aes-256-cbc -pbkdf2 -salt -in - -out - -k " .. password,
    lines
  )
end

local function decrypt()
  local password = helpers.getPassword()
  local encrypted_lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
  local decrypted_lines = decrypt_lines(encrypted_lines, password)
  if vim.v.shell_error ~= 0 then
    vim.notify("Error decrypting", vim.log.levels.ERROR)
    return
  end

  vim.fn.timer_start(0, function()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, decrypted_lines)
    vim.bo.modified = false
  end)
end

return decrypt
