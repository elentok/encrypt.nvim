local encrypt = require("encrypt.encrypt")

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

local function setupBuffer()
  -- buftype="acwrite" means save using the BufWriteCmd command
  vim.bo.buftype = "acwrite"
  vim.bo.swapfile = false
  vim.bo.undofile = false
  vim.b["encrypted"] = true
  createWriteAutoCmd()
end

return setupBuffer
