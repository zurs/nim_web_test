import asynchttpserver, tables, strutils

import serviceContainer

type
    RequestContext* = ref object
        originalRequest*: Request
        path*: string
        httpMethod*: HttpMethod
        data: Table[string, string]
        response*: string
        container: ServiceContainer 


proc parseRequest*(req: Request): RequestContext =
    var newContext = RequestContext()
    newContext.data = initTable[string, string]()
    newContext.originalRequest = req
    newContext.path = req.url.path
    newContext.httpMethod = req.reqMethod
    if req.url.query.len != 0:
        let queryPairs = split(req.url.query, '&')
        for pair in queryPairs:
            let separatedPair = split(pair, '=')
            newContext.data[separatedPair[0]] = separatedPair[1]
    return newContext

proc includeContainer*(ctx: var RequestContext, container: var ServiceContainer) =
    ctx.container = container

proc getContainer*(ctx: var RequestContext): ServiceContainer =
    if ctx.container.isNil:
        return nil
    return ctx.container


proc getPOST*(ctx: RequestContext, key: string): string =
    if ctx.data.hasKey(key):
        return ctx.data[key]
    else:
        return ""

proc getGET*(ctx: RequestContext, key: string): string =
    return getPOST(ctx, key)