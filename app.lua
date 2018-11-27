local app = require("subapp")
app:enable("etlua")
app.layout = require("views.layout")

app:get("index", "/", require("actions.index-get"))

app:include("applications.foo")
app:include("applications.bar")

return app
