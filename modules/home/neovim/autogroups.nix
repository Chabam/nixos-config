{ ... }:
''
  -- Clear whitespace on save
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
  })

  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  vim.api.nvim_create_autocmd({"TermOpen"},
    {
      pattern = "term://*",
      callback = function(opts)
        vim.cmd("startinsert")
        vim.cmd("setlocal nonumber")
        vim.cmd("setlocal norelativenumber")
        vim.cmd("setlocal signcolumn=no")
      end
    })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end
      local fzf = require("fzf-lua")

      local lsp_fzf_opts = {
        jump1 = true,
      }

      map("gd", function()
        fzf.lsp_definitions(lsp_fzf_opts)
      end, "[G]oto [D]efinition")

      map("gr", function()
        fzf.lsp_references(lsp_fzf_opts)
      end, "[G]oto [R]eferences")

      map("gI", function()
        fzf.lsp_implementations(lsp_fzf_opts)
      end, "[G]oto [I]mplementation")

      map("<leader>D", function()
        fzf.lsp_typedefs(lsp_fzf_opts)
      end, "Type [D]efinition")

      map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
      map("<leader>ws", fzf.lsp_workspace_symbols, "[W]orkspace [S]ymbols")

      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

      map("<leader>ca", require("fzf-lua").lsp_code_actions, "[C]ode [A]ction", { "n", "x" })

      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map("gH", "<CMD>ClangdSwitchSourceHeader<CR>", "[G]oto [H]eader", { "n", "x" })

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup =
          vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
          end,
        })
      end

      if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })
''
