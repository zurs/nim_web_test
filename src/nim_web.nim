import asynchttpserver, asyncdispatch, tables

import contextBuilder, router

var server = newAsyncHttpServer()

proc startPoint(req: Request) {.async.} =
    # First, build the ctx object
    var ctx = contextBuilder.parseRequest(req)
    ctx.response = ctx.getGET("myquery")

    # Second, route it!


    await req.respond(Http200, ctx.response)

echo("Starting to serve on port 8080")
waitFor server.serve(Port(8080), startPoint)