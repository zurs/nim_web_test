import routerService

type
    ServiceContainer* = ref object
        router: Router

proc newServiceContainer*(): ServiceContainer =
    return ServiceContainer()

proc getRouter*(container: var ServiceContainer): var Router =
    if container.router.isNil():
        container.router = routerService.newRouter()
    return container.router