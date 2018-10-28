import contextBuilder

type
    Route* = object
        regexp: string
        lambdaProc: proc(x: RequestContext)
    RouteCollection* = ref object
        routes: seq[Route]
    Router* = ref object
        collections: seq[RouteCollection]

proc route*(collection: RouteCollection, ctx: RequestContext) =
    discard

proc add*(collection: RouteCollection, route: Route) =
    collection.add(route)

proc newRouter*(): Router =
    return Router(collections: @[RouteCollection()])

proc defaultCollection(router: var Router): RouteCollection =
    return router.collections[0]