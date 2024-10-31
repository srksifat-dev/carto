import 'package:carto/core/routes/routes.dart';
import 'package:carto/features/auth/presentation/pages/auth_screen.dart';
import 'package:carto/features/cart/presentation/pages/cart_screen.dart';
import 'package:carto/features/shop/presentation/pages/shop_screen.dart';
import 'package:go_router/go_router.dart';

import 'error_screen.dart';

class RouteGenerator {
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        name: Routes.shop,
        path: '/',
        builder: (context,state)=> ShopScreen(),
      ),
      GoRoute(
        name: Routes.auth,
        path: '/${Routes.auth}',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        name: Routes.cart,
        path: '/${Routes.cart}',
        builder: (context, state) => const CartScreen(),
      ),
    ],
  );
}
