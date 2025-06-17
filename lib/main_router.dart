import 'package:auto_route/auto_route.dart';
import 'package:dalui/main_router.gr.dart';

@AutoRouterConfig()
class MainRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: KindRoute.page, path: '/kind', initial: true),
  ];
}
