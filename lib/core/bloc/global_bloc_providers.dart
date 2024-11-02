import 'package:carto/core/di/injection_container.dart' as di;
import 'package:carto/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:carto/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:carto/features/shop/presentation/cubits/shop_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? userId;
class GlobalBlocProviders {
  dynamic providers = [
    BlocProvider(create: (_) => di.sl<AuthCubit>()..checkAuth()),
    BlocProvider(create: (_) => di.sl<ShopCubit>()),
    BlocProvider(create: (_) => di.sl<CartCubit>()..getAllCarts(userId: userId!)),
  ];
}