describe("lsyslog", function()
  local lsyslog

  before_each(function()
    lsyslog = require "lsyslog"
  end)

  after_each(function()
    package.loaded.lsyslog = nil
    _G.lsyslog = nil
  end)


  it("global is set only on Lua 5.1", function()
    if _G._VERSION == "Lua 5.1" then
      assert.equal(lsyslog, _G.lsyslog)
    else
      assert.equal(nil, _G.lsyslog)
    end
  end)


  it("has open, log and close function", function()
    assert.is_function(lsyslog.open)
    assert.is_function(lsyslog.log)
    assert.is_function(lsyslog.close)
  end)


  it("has LOG_xxx constants", function()
    assert.is.not_nil(lsyslog.LOG_ERR)
  end)


  it("has FACILITY_xxx constants", function()
    assert.is.not_nil(lsyslog.FACILITY_SYSLOG)
  end)

end)
