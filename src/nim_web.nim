import asynchttpserver, asyncdispatch, tables, re, sugar

import contextHelper, routerService, serviceContainer, routes

var server = newAsyncHttpServer()

var container = newServiceContainer() 

var someRoute = Route(regexp: re"(/)", routeProc: proc(myCtx: var RequestContext) = 
    myCtx.response = "Yolo"
)

routes.addRoutes(container.getRouter())

proc startPoint(req: Request) {.async, gcsafe.} =
    # First, build the ctx object
    echo(req)
    var ctx = contextHelper.parseRequest(req)
    ctx.response = ctx.getGET("myquery")

    # Second, route it!
    container.getRouter().execRouting(ctx)

    await req.respond(Http200, ctx.response)

echo("Starting to serve on port 8080")
waitFor server.serve(Port(8080), startPoint)