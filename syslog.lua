require"logging"
require"lsyslog"

local convert =
{
	[logging.DEBUG] = lsyslog.LOG_DEBUG,
	[logging.INFO]  = lsyslog.LOG_INFO,
	[logging.WARN]  = lsyslog.LOG_WARNING,
	[logging.ERROR] = lsyslog.LOG_ERR,
	[logging.FATAL] = lsyslog.LOG_ALERT,
}

function logging.syslog(ident, facility)
	if type(ident) ~= "string" then
		ident = "lua"
	end
	lsyslog.open(ident, facility or lsyslog.FACILITY_USER)
	return logging.new(function(self, level, message)
		lsyslog.log(convert[level] or lsyslog.LOG_ERR, message)
		return true
	end)
end
