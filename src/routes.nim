import re

import routerService, contextHelper

proc addRoutes*(router: var Router) =

    router.add(Route(regexp: re"/kalle/", routeProc: proc(ctx: var RequestContext) = 
        ctx.response = "Kalle?"
    ))

    router.add(Route(regexp: re"/", routeProc: proc(myCtx: var RequestContext) =
        myCtx.response = "Yolo, this is from the other file"
    ))

    