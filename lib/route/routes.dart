




import 'package:downlaod_image_pinchzoom/route/routes_name.dart';
import 'package:downlaod_image_pinchzoom/view/screen1/screen_1.dart';
import 'package:downlaod_image_pinchzoom/view/screen2/screen_2.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.screen1,
      builder: (context, state) {
        return const Screen1();
      },
    ),
    GoRoute(
      path: RoutesName.screen2,
      builder: (context, state) {
        return const Screen2();
      },
    ),

  ],
);
