local M = {}

function M.config()
	require("xcodebuild").setup({
		integrations = {
			xcode_build_server = {
				enabled = true,
			},
		},
	})

	local cmd = vim.cmd

	vim.keymap.set("n", "<leader>E", cmd.XcodebuildPicker, { desc = "Show Xcodebuild Actions" })
	vim.keymap.set("n", "<leader>ef", cmd.XcodebuildProjectManager, { desc = "Show Project Manager Actions" })

	vim.keymap.set("n", "<leader>eb", cmd.XcodebuildBuild, { desc = "Build Project" })
	vim.keymap.set("n", "<leader>eB", cmd.XcodebuildBuildForTesting, { desc = "Build For Testing" })
	vim.keymap.set("n", "<leader>er", cmd.XcodebuildBuildRun, { desc = "Build & Run Project" })

	vim.keymap.set("n", "<leader>et", cmd.XcodebuildTest, { desc = "Run Tests" })
	vim.keymap.set("v", "<leader>et", cmd.XcodebuildTestSelected, { desc = "Run Selected Tests" })
	vim.keymap.set("n", "<leader>eT", cmd.XcodebuildTestClass, { desc = "Run This Test Class" })

	vim.keymap.set("n", "<leader>el", cmd.XcodebuildToggleLogs, { desc = "Toggle Xcodebuild Logs" })
	vim.keymap.set("n", "<leader>ec", cmd.XcodebuildToggleCodeCoverage, { desc = "Toggle Code Coverage" })
	vim.keymap.set("n", "<leader>eC", cmd.XcodebuildShowCodeCoverageReport, { desc = "Show Code Coverage Report" })
	vim.keymap.set("n", "<leader>ee", cmd.XcodebuildTestExplorerToggle, { desc = "Toggle Test Explorer" })
	vim.keymap.set("n", "<leader>es", cmd.XcodebuildFailingSnapshots, { desc = "Show Failing Snapshots" })

	vim.keymap.set("n", "<leader>ed", cmd.XcodebuildSelectDevice, { desc = "Select Device" })
	vim.keymap.set("n", "<leader>ep", cmd.XcodebuildSelectTestPlan, { desc = "Select Test Plan" })
	vim.keymap.set("n", "<leader>eq", function()
		cmd.Telescope({ "quickfix" })
	end, { desc = "Show QuickFix List" })

	vim.keymap.set("n", "<leader>ex", cmd.XcodebuildQuickfixLine, { desc = "Quickfix Line" })
	vim.keymap.set("n", "<leader>ea", cmd.XcodebuildCodeActions, { desc = "Show Code Actions" })
end

return M
