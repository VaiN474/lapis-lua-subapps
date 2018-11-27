## lapis-lua-subapps

This is a simple Lua script that adds sub-application support for Lua projects in the [Lapis](http://leafo.net/lapis) web framework.

#### How it works

The script overrides the `app:include` function. This may make it incompatible with moonscript projects, but if you're using moonscript then you don't need this as sub-application support is already built-in for moonscript projects.

It works similar to how it is [documented](http://leafo.net/lapis/reference/moon_getting_started.html#moonscript-tips/sub-applications) for moonscript.

The main differences are that the application name and path *must* be defined in the sub-application.

#### Additional Features

This also adds support for application-specific layouts :)

The code is pretty straight-forward so it's easy to expand upon if you want to add more features.

## Usage

This repo includes a full example project for reference, but the only file you would need to add to your project is the `subapp.lua` file.

To enable sub-app support, you just need to change the lapis `app` definition in your `app.lua` file:

```
local app = lapis.Application()
-- change to:
local app = require("subapp")
```

Then you can use `app:include` to include your sub-apps:

```
app:include("applications.foo")
app:include("applications.bar")
```

A sub-app should be a module-like script that returns a table:

```
local foo = {}

foo.name = "foo"
foo.path = "/foo"
foo.layout = "foo.layout"

foo.routes = {}

return foo
```

The `name` and `path` definitions are required, but the layout is optional.

Routes are written in a way similar to how they are usually compiled from moonscript, but we take care of wrapping them in a `respond_to` call in the background.

```
[{ index = "/index" }] = {
    before = function(self)
      -- do something before this route
    end,
    GET = function(self)
      -- respond to GET requests here
    end,
    POST = function(self)
      -- respond to POST requests here
    end
  },
}
```

The route types are optional, you only need to include what is needed (GET, POST, ect). All routes are named. If you need to handle routes differently, you would have to add that support yourself.

The subapp script will take care of renaming the routes for you based on the `app.path` value. In this example, `/index` becomes `/foo/index`.

If you're action in a route returns `render = true`, it will look for a matching template in `views/<app name>/<route name>`. For this example it would be `views/foo/index.etlua`.

Sub-apps can also include a `before_filter`:

```
foo.before_filter = function(self)
  -- do something before all routes in this app
end
```
