import 'package:carto/core/routes/route_generator.dart';
import 'package:carto/core/routes/routes.dart';
import 'package:carto/core/utils/extensions/screen_size_extension.dart';
import 'package:carto/core/utils/extensions/widget_extensions.dart';
import 'package:carto/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:carto/features/cart/domain/entities/cart_entity.dart';
import 'package:carto/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:carto/features/shop/domain/entities/product_entity.dart';
import 'package:carto/features/shop/presentation/cubits/shop_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../cubits/shop_state.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final authCubit = context.read<AuthCubit>();
    final userId = authCubit.currentUser!.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CARTO",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.cart);
            },
            icon: Icon(
              Icons.shopping_cart_checkout,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ShopError) {
            return const Center(
              child: Icon(Icons.refresh),
            );
          }
          if (state is ShopFulfillDone) {
            List<ProductEntity> products = state.products!;
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7),
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: context.screenHeight * 16,
                      child: Image.network(
                        products[index].image!,
                        errorBuilder: (_, __, ___) => Icon(Icons.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].title!,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${products[index].price!.toString()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    products[index].rating!.rate!.toString(),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            cartCubit.addToCart(
                              cartItem: CartEntity(
                                  id: Uuid().v4(),
                                  productId: products[index].id!.toString(),
                                  quantity: 1,
                                  totalPrice:
                                      products[index].price!.toDouble()),
                              userId: userId,
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: 16);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
