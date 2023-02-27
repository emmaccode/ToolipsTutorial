module MarkdownBrowser
using Toolips
using ToolipsSession
using ToolipsDefaults
using ToolipsMarkdown
# welcome to your new toolips project!

function build_documents(c::Connection)
        backbutton = button("backbutton", text = "<-")
        on(c, backbutton, "click") do cm::ComponentModifier
            set_children!(cm, "mainbox", build_documents(c))
        end
        docs = Vector{Servable}([begin
        b = button("$mdfile-button", text = mdfile)
        on(c, b, "click") do cm::ComponentModifier
            f = read("public/documents/$mdfile", String)
            set_children!(cm, "mainbox", [backbutton, tmd("mainmd", f)])
        end
        b::Component{:button}
        end for mdfile in readdir("public/documents")])
end
"""
home(c::Connection) -> _
--------------------
The home function is served as a route inside of your server by default. To
    change this, view the start method below.
"""
function home(c::Connection)
    write!(c, ToolipsDefaults.sheet("mainstyles"))
    bod::Component{:body} = body("mainbody")
    header::Component{:div} = div("header", align = "center")
    push!(header, h("mainheading", 2, text = "Markdown Browser"))
    mainbox::Component{:div} = div("mainbox")
    mainbox[:children] = build_documents(c)
    push!(bod, header, mainbox)
    write!(c, bod)
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
