import 'package:carto/core/routes/routes.dart';
import 'package:carto/features/auth/domain/repositories/auth_repository.dart';
import 'package:carto/features/auth/presentation/pages/auth_checker.dart';
import 'package:carto/features/auth/presentation/pages/auth_screen.dart';
import 'package:carto/features/cart/presentation/pages/cart_screen.dart';
import 'package:carto/features/shop/presentation/pages/shop_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:carto/core/di/injection_container.dart' as di;

import 'error_screen.dart';

class RouteGenerator {
  // final AuthRepository authRepository = di.sl<AuthRepository>();
  late final GoRouter router = GoRouter(
    initialLocation: "/",
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    // redirect: (context,state)async{
    //   final isLoggedIn = await authRepository.;
    //   if (isLoggedIn){
    //     return Routes.shop;
    //   }else{
    //     return "/${Routes.auth}";
    //   }
    // },
    routes: [
      GoRoute(
        name: Routes.authCheck,
        path: '/',
        builder: (context,state)=> AuthChecker(),
      ),
      GoRoute(
        name: Routes.shop,
        path: '/shop',
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
