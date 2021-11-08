library router;

import 'package:auto_route/auto_route.dart';
import 'package:sample_architecture/ui_kit/ui_kit.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen|Part,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: AppSplashScreen, path: '/splash'),
  ],
)

/// Generated [RootRouter] class
class $RootRouter {}
