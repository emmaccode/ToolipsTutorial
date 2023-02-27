using Pkg; Pkg.activate(".")
using Toolips
using Revise
using ArgPostGet

IP = "127.0.0.1"
PORT = 8000
ArgPostGetServer = ArgPostGet.start(IP, PORT)
