module ArgHeading
using Toolips

# welcome to your new toolips project!
"""
home(c::Connection) -> _
--------------------
The home function is served as a route inside of your server by default. To
    change this, view the start method below.
"""
function home(c::Connection)
    args = getargs(c)
    number = args[:h]
    n = parse(Int64, number)
    n += 5
    write!(c, DOCTYPE())
    write!(c, h("result", 2, text = string(n)))
end

fourofour = route("404") do c::Connection
    write!(c, p("404message", text = "404, not found!"))
end

routes = [route("/", home), fourofour]
extensions = Vector{ServerExtension}([Logger(), ])
"""
start(IP::String, PORT::Integer, ) -> ::ToolipsServer
--------------------
The start function starts the WebServer.
"""
function start(IP::String = "127.0.0.1", PORT::Integer = 8000)
     ws = WebServer(IP, PORT, routes = routes, extensions = extensions)
     ws.start(); ws::WebServer
end
end # - module
