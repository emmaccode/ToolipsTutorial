using Pkg; Pkg.activate(".")
using Toolips
using Revise
using ArgHeading

IP = "127.0.0.1"
PORT = 8000
ArgHeadingServer = ArgHeading.start(IP, PORT)
