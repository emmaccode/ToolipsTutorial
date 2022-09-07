using Pkg; Pkg.activate(".")
using Toolips
using ToolipsSession
using OurApp

IP = "127.0.0.1"
PORT = 8000
OurAppServer = OurApp.start(IP, PORT)
