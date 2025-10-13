return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		auto_restore = false,
		suppressed_dirs = { "/" },
		-- log_level = 'debug',
	},
}
