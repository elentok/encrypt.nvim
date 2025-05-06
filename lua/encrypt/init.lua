local setupBuffer = require("encrypt.setup-buffer")
local encrypt = require("encrypt.encrypt")
local decrypt = require("encrypt.decrypt")
local helpers = require("encrypt.helpers")

local function setup()
  vim.api.nvim_create_user_command("X", function()
    if helpers.bufferEncrypted() then
      setupBuffer(helpers.BUFTYPE.encrypted)
      decrypt()
    else
      setupBuffer(helpers.BUFTYPE.plaintext)
      encrypt()
    end
  end, {})

  vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = function()
      if helpers.bufferEncrypted() then
        setupBuffer(helpers.BUFTYPE.encrypted)
        decrypt()
      end
    end,
  })
end

return { setup = setup }
