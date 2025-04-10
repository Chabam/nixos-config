{ pkgs }:
with pkgs.vimPlugins;
# Lua
''
  {
    dir = "${gitsigns-nvim}",
    event = "BufRead",
    keys = {
      {
        ']c',
        function()
          if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
          else
              require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "Jump to next git [c]hange"
      },
      {
        "[c",
        function()
          if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
          else
              require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "Jump to previous git [c]hange"
      },
      {
        "<leader>hs",
        function()
          require("gitsigns").stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end,
        "v",
        desc = "git [h]unk stage"
      },
      {
        "<leader>hr",
        function()
          require("gitsigns").reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end,
        "v",
        desc = "git [h]unk reset"
      },
      {
        "<leader>hs",
        require("gitsigns").stage_hunk,
        desc = "git [h]unk [s]tage hunk"
      },
      {
        "<leader>hr",
        require("gitsigns").reset_hunk,
        desc = "git [h]unk [r]eset hunk"
      },
      {
        "<leader>hS",
        require("gitsigns").stage_buffer,
        desc = "git [h]unk [S]tage buffer"
      },
      {
        "<leader>hu",
        require("gitsigns").undo_stage_hunk,
        desc = "git [h]unk [u]ndo stage hunk",
      },
      {
        "<leader>hR",
        require("gitsigns").reset_buffer,
        desc = "git [h]unk [R]eset buffer",
      },
      {
        "<leader>hp",
        require("gitsigns").preview_hunk,
        desc = "git [h]unk [p]review hunk"
      },
      {

        "<leader>hb",
        require("gitsigns").blame_line,
        desc = 'git [h]unk [b]lame line'
      },
      {
        "<leader>hd",
        require("gitsigns").diffthis,
        desc = "git [h]unk [d]iff against index"
      },
      {
        "<leader>hD",
        function()
          require("gitsigns").diffthis("@")
        end,
        desc = "git [h]unk [D]iff against last commit"
      },
      {
        "<leader>tb",
        require("gitsigns").toggle_current_line_blame,
        desc = "[T]oggle git show [b]lame line"
      },
      {
        "<leader>tD",
        require("gitsigns").toggle_deleted,
        desc = "[T]oggle git show [D]eleted"
      }
    },
    config = function()
        require("gitsigns").setup({})
    end
  }
''
