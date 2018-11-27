local foo = {}

foo.name = "foo"
foo.path = "/foo"
foo.layout = "foo.layout"
foo.before_filter = function(self)
  -- do something before all routes in this app
end

foo.routes = {

  [{ index = "/index" }] = {
    before = function(self)
      -- do something before this route
    end,
    GET = require("actions.foo.index-get"),
    POST = function(self)
      return { render = true }
    end
  },

  [{ about = "/about" }] = {
    before = function(self) end,
    GET = require("actions.foo.about-get"),
    POST = function(self)
      return { render = true }
    end
  },

}

return foo
