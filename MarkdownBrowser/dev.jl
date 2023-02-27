using Pkg; Pkg.activate(".")
using Toolips
using Revise
using MarkdownBrowser

IP = "127.0.0.1"
PORT = 8000
MarkdownBrowserServer = MarkdownBrowser.start(IP, PORT)
