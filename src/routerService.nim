import contextHelper, re, sugar

type
    Route* = object
        regexp*: Regex
        routeProc*: proc(x: var RequestContext) {.gcsafe, nimcall.}
    Router* = ref object
        routes: seq[Route]

proc add*(router: var Router, route: Route) =
    router.routes.add(route)

proc newRouter*(): Router =
    return Router(routes: @[])

proc route*(regexp: Regex, localProc: proc(ctx: var RequestContext) {.nimcall, gcsafe.}): Route =
    return Route(regexp: regexp, routeProc: localProc)

proc execRouting*(router: var Router, ctx: var RequestContext) =
    for route in router.routes:
        if ctx.path.match(route.regexp) == true:
            route.routeProc(ctx)
            break

