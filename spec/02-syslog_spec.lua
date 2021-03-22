local lsyslog = require "lsyslog"

describe("syslog", function()
  local syslog

  before_each(function()
    stub(lsyslog, "open")
    stub(lsyslog, "log")
    stub(lsyslog, "close")

    syslog = require "syslog" -- also requires 'logging'
  end)

  after_each(function()
    lsyslog.open:revert()
    lsyslog.log:revert()
    lsyslog.close:revert()

    package.loaded.syslog = nil
    package.loaded.logging = nil
  end)


  it("writes a message to syslog", function()
    local logger = syslog {
      ident = "busted test",
      facility = syslog.FACILITY_USER,
    }

    logger:debug("test log message")

    assert.stub(lsyslog.open).was.called_with("busted test", syslog.FACILITY_USER)
    assert.stub(lsyslog.log).was.called_with(lsyslog.LOG_DEBUG, "test log message")
  end)


  it("sets proper defaults upon creation", function()
    local logger = syslog()

    logger:debug("test log message")

    assert.stub(lsyslog.open).was.called_with("lua", syslog.FACILITY_USER)
  end)


  it("installs itself in lualogging", function()
    local logging = require "logging"
    local logger = logging:syslog()  -- instanciate from lualogging

    logger:debug("test log message")

    assert.stub(lsyslog.open).was.called_with("lua", syslog.FACILITY_USER)
  end)


  it("formats according to logPattern", function()
    local logger = syslog {
      ident = "busted test",
      facility = syslog.FACILITY_USER,
      logPattern = "[%level] %message",
    }

    logger:debug("test log message")

    assert.stub(lsyslog.log).was.called_with(lsyslog.LOG_DEBUG, "[DEBUG] test log message")
  end)

end)
