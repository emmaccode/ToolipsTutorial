module OurApp
using Toolips
using ToolipsSession
# welcome to your new toolips project!
"""
home(c::Connection) -> _
--------------------
The home function is served as a route inside of your server by default. To
    change this, view the start method below.
"""
function home(c::Connection)
    ourbody = body("ourbody")
    newdiv = div("newdiv", align = "center")
    newheading = h("newheading", 2, text = "Hello there!", color = "red")
    style!(newheading, "color" => "red", "transition" => "5s")
    newbutton = button("newbutton", text = "click me to change color")
    on(c, newbutton, "click") do cm::ComponentModifier
        if cm[newheading]["color"] == "red"
            style!(cm, newheading, "color" => "blue")
            cm[newheading] = "color" => "blue"
        else
            style!(cm, newheading, "color" => "red")
            cm[newheading] = "color" => "red"
        end
    end
    push!(newdiv, newheading, newbutton)
    push!(ourbody, newdiv)
    write!(c, ourbody)
end

fourofour = route("404") do c
    write!(c, p("404message", text = "404, not found!"))
end

routes = [route("/", home), fourofour]
extensions = Vector{ServerExtension}([Logger(), Files(), Session(), ])
"""
start(IP::String, PORT::Integer, ) -> ::ToolipsServer
--------------------
The start function starts the WebServer.
"""
function start(IP::String = "127.0.0.1", PORT::Integer = 8000)
     ws = WebServer(IP, PORT, routes = routes, extensions = extensions)
     ws.start(); ws
end
end # - module
