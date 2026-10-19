-- C / C++: cmake-tools for generate/build/run/test, nvim-dap + dap-ui for debugging.
-- Debug adapter is codelldb (installed by mason). gdb does not work on macOS.
-- lldb-dap from the Xcode command line tools is registered as a fallback ("lldb").

local function codelldb_path()
  local mason = vim.fn.stdpath('data') .. '/mason/bin/codelldb'
  if vim.fn.executable(mason) == 1 then return mason end
  return vim.fn.exepath('codelldb')
end

local function lldb_dap_path()
  if vim.fn.executable('lldb-dap') == 1 then return 'lldb-dap' end
  local out = vim.fn.system({ 'xcrun', '-f', 'lldb-dap' })
  if vim.v.shell_error == 0 then return vim.trim(out) end
  return nil
end

-- ask mason to install a package once (runs in the background on first load)
local function mason_ensure(name)
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then return end
  registry.refresh(function()
    local has, pkg = pcall(registry.get_package, name)
    if has and not pkg:is_installed() then
      vim.notify('mason: installing ' .. name, vim.log.levels.INFO)
      pkg:install()
    end
  end)
end

-- path to the binary to debug. cmake project: the selected launch target, or a picker
-- over executable targets if none is selected yet. otherwise ask (defaults to build/).
local function pick_program()
  local ok, ct = pcall(require, 'cmake-tools')
  if ok and ct.is_cmake_project() then
    local target = ct.get_launch_target_path()
    if target and target ~= '' then return target end
    -- nvim-dap runs this inside a coroutine, so an async picker can hand the value back
    return coroutine.create(function(co)
      ct.select_launch_target(false, function()
        coroutine.resume(co, ct.get_launch_target_path())
      end)
    end)
  end
  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
end

return {
  {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
    ft = { 'c', 'cpp', 'cmake' },
    cmd = { 'CMakeGenerate', 'CMakeBuild', 'CMakeRun', 'CMakeDebug', 'CMakeSelectBuildTarget',
            'CMakeSelectLaunchTarget', 'CMakeSelectBuildType', 'CMakeRunTest', 'CMakeClean',
            'CMakeOpenExecutor', 'CMakeCloseExecutor', 'CMakeOpenRunner', 'CMakeCloseRunner' },
    opts = {
      cmake_build_directory = 'build',
      cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' },
      cmake_build_options = { '-j' },
      cmake_regenerate_on_save = true,
      -- symlink build/compile_commands.json to the project root for clangd
      cmake_compile_commands_options = { action = 'soft_link', target = vim.loop.cwd },
      cmake_dap_configuration = {
        name = 'cmake target',
        type = 'codelldb',
        request = 'launch',
        stopOnEntry = false,
        runInTerminal = true,
        console = 'integratedTerminal',
      },
      -- builds go to the quickfix list, programs run in a terminal split
      cmake_executor = { name = 'quickfix', opts = { show = 'only_on_error', auto_close_when_success = true } },
      cmake_runner = { name = 'terminal', opts = { split_size = 15 } },
      cmake_virtual_text_support = false, -- lualine shows the target instead
    },
    config = function(_, opts)
      require('cmake-tools').setup(opts)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user_cmake_keys', { clear = true }),
        pattern = { 'c', 'cpp', 'cmake' },
        callback = function(ev)
          local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
          end
          map('<localleader>cg', '<cmd>CMakeGenerate<CR>', 'cmake: generate')
          map('<localleader>cb', '<cmd>CMakeBuild<CR>', 'cmake: build')
          map('<localleader>cr', '<cmd>CMakeRun<CR>', 'cmake: run launch target')
          map('<localleader>cd', '<cmd>CMakeDebug<CR>', 'cmake: debug launch target')
          map('<localleader>ct', '<cmd>CMakeRunTest<CR>', 'cmake: run tests (ctest)')
          map('<localleader>cc', '<cmd>CMakeSelectBuildTarget<CR>', 'cmake: select build target')
          map('<localleader>cl', '<cmd>CMakeSelectLaunchTarget<CR>', 'cmake: select launch target')
          map('<localleader>cy', '<cmd>CMakeSelectBuildType<CR>', 'cmake: select build type')
          map('<localleader>cx', '<cmd>CMakeStopExecutor<CR>', 'cmake: stop build')
          map('<localleader>cq', '<cmd>CMakeOpenExecutor<CR>', 'cmake: show build output')
        end,
      })
      -- keymaps above are registered on FileType; fire once for the buffer that triggered loading
      vim.api.nvim_exec_autocmds('FileType', { group = 'user_cmake_keys', pattern = vim.bo.filetype })
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
      'theHamsta/nvim-dap-virtual-text',
      'mason-org/mason.nvim',
    },
    keys = {
      { '<localleader>db', function() require('dap').toggle_breakpoint() end, desc = 'dap: toggle breakpoint' },
      { '<localleader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'dap: conditional breakpoint' },
      { '<localleader>dc', function() require('dap').continue() end, desc = 'dap: continue / start' },
      { '<localleader>ds', function() require('dap').step_over() end, desc = 'dap: step over' },
      { '<localleader>di', function() require('dap').step_into() end, desc = 'dap: step into' },
      { '<localleader>do', function() require('dap').step_out() end, desc = 'dap: step out' },
      { '<localleader>dx', function() require('dap').terminate() end, desc = 'dap: terminate' },
      { '<localleader>dl', function() require('dap').run_last() end, desc = 'dap: run last' },
      { '<localleader>dr', function() require('dap').repl.toggle() end, desc = 'dap: repl' },
      { '<localleader>du', function() require('dapui').toggle() end, desc = 'dap: toggle ui' },
      { '<localleader>de', function() require('dapui').eval() end, mode = { 'n', 'v' }, desc = 'dap: eval' },
      { '<localleader>dh', function() require('dap.ui.widgets').hover() end, mode = { 'n', 'v' }, desc = 'dap: hover value' },
      { '<F5>', function() require('dap').continue() end, desc = 'dap: continue' },
      { '<F10>', function() require('dap').step_over() end, desc = 'dap: step over' },
      { '<F11>', function() require('dap').step_into() end, desc = 'dap: step into' },
      { '<F12>', function() require('dap').step_out() end, desc = 'dap: step out' },
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      mason_ensure('codelldb')

      ------------------------------------------------------------ adapters
      dap.adapters.codelldb = function(callback, _)
        local cmd = codelldb_path()
        if cmd == '' then
          vim.notify('codelldb not found. run :MasonInstall codelldb', vim.log.levels.ERROR)
          return
        end
        callback({
          type = 'server',
          port = '${port}',
          executable = { command = cmd, args = { '--port', '${port}' } },
        })
      end

      local lldb_dap = lldb_dap_path()
      if lldb_dap then
        dap.adapters.lldb = { type = 'executable', command = lldb_dap, name = 'lldb' }
      end

      ------------------------------------------------------------ configurations
      dap.configurations.cpp = {
        {
          name = 'Launch (codelldb)',
          type = 'codelldb',
          request = 'launch',
          program = pick_program,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
        {
          name = 'Launch with arguments (codelldb)',
          type = 'codelldb',
          request = 'launch',
          program = pick_program,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = function()
            return vim.split(vim.fn.input('Arguments: '), ' +', { trimempty = true })
          end,
        },
        {
          name = 'Attach to process (codelldb)',
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
      if lldb_dap then
        table.insert(dap.configurations.cpp, {
          name = 'Launch (lldb-dap, Xcode)',
          type = 'lldb',
          request = 'launch',
          program = pick_program,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        })
      end
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.zig = dap.configurations.cpp

      ------------------------------------------------------------ ui
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.4 },
              { id = 'watches', size = 0.2 },
              { id = 'stacks', size = 0.2 },
              { id = 'breakpoints', size = 0.2 },
            },
            size = 45,
            position = 'left',
          },
          {
            elements = { { id = 'repl', size = 0.5 }, { id = 'console', size = 0.5 } },
            size = 12,
            position = 'bottom',
          },
        },
        floating = { border = 'rounded' },
      })
      require('nvim-dap-virtual-text').setup({ commented = true })

      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DiagnosticHint' })
      vim.fn.sign_define('DapLogPoint', { text = '◉', texthl = 'DiagnosticInfo' })
      vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticOk', linehl = 'Visual' })
    end,
  },
}
