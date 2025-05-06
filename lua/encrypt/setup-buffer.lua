local encrypt = require("encrypt.encrypt")
local helpers = require("encrypt.helpers")

local function createWriteAutoCmd()
  if vim.b["encryptionAutoCmd"] ~= nil then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  vim.b["encryptionAutoCmd"] = vim.api.nvim_create_autocmd({ "BufWriteCmd" }, {
    buffer = bufnr,
    callback = function()
      if vim.b["encrypted"] ~= true then
        return
      end

      encrypt()
    end,
  })
end

---@param buftype buftype
local function setupBuffer(buftype)
  -- buftype="acwrite" means save using the BufWriteCmd command
  vim.bo.buftype = "acwrite"
  vim.bo.swapfile = false
  vim.bo.undofile = false
  vim.b["encrypted"] = true
  -- Lock the encrypted file to read-only mode to avoid corruption
  -- caused by unintended modifications.
  if buftype == helpers.BUFTYPE.encrypted then
    vim.bo.modifiable = false
  end
  createWriteAutoCmd()
end

return setupBuffer
