import 'package:go_router/go_router.dart';

class FluRouter {
  final List<RouteBase> routes;

  FluRouter(this.routes);

  GoRouter getRouterConfig() => GoRouter(routes: routes);
}

class FluRoute extends GoRoute {
  FluRoute(
      {required super.path,
      super.name,
      super.builder,
      super.pageBuilder,
      super.parentNavigatorKey,
      super.redirect,
      super.routes})
      : super();
}
