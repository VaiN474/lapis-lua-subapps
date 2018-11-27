local bar = {}

bar.name = "bar"
bar.path = "/bar"
bar.layout = "bar.layout"
bar.before_filter = function(self)
  -- do something before all routes in this app
end

bar.routes = {

  [{ index = "/index" }] = {
    before = function(self)
      -- do something before this route
    end,
    GET = require("actions.bar.index-get"),
    POST = function(self)
      return { render = true }
    end
  },

  [{ test = "/test" }] = {
    before = function(self) end,
    GET = require("actions.bar.test-get"),
    POST = function(self)
      return { render = true }
    end
  },

}

return bar
