import 'package:carto/core/utils/extensions/widget_extensions.dart';
import 'package:carto/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/global_bloc_providers.dart';
import '../../data/models/cart_model.dart';
import '../cubits/cart_state.dart';
import '../widgets/cart_card.dart';
import '../widgets/checkout_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final cartCubit = context.read<CartCubit>();

  void getAllCart() {
    cartCubit.getAllCarts(userId: userId!);
  }

  double countTotalAmount(int quantity, double price) {
    return quantity * price;
  }

  @override
  void initState() {
    getAllCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Column(
            children: [
              Text(
                "Your Cart",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is CartLoaded) {
              if(state.carts.isEmpty){
                return const Center(child: Text("There is no product in your cart"),);
              }
              List<CartModel> cartItems = state.carts;
              final totalAmount = state.totalAmount;
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        CartModel cart = cartItems[index];
                        void incrementQuantity(int oldQuantity) async {
                          setState(() {
                            cart.quantity++;

                          });
                          cartCubit
                              .updateQuantity(
                            productId: cart.product.id.toString(),
                            isIncrement: true,
                            userId: userId!,)
                              .catchError((_) {
                            setState(() {
                              cart.quantity--;

                            });
                          });
                        }

                        void decrementQuantity(int oldQuantity) async {
                          if (oldQuantity > 1) {
                            setState(() {
                              cart.quantity--;
                              // totalAmount(quantity, widget.cart.product.price!.toDouble());
                            });
                            cartCubit
                                .updateQuantity(
                              productId: cart.product.id.toString(),
                              isIncrement: false,
                              userId: userId!,)
                                .catchError((_) {
                              setState(() {
                                cart.quantity++;
                                // totalAmount(quantity, cart.product.price!.toDouble());
                              });
                            });
                          }
                        }

                        void deleteCart(String productId)async{
                          cartCubit.deleteCart(productId: productId);
                        }

                        return cartCard(cart: cart, context: context, decrementQuantity: decrementQuantity,
                            incrementQuantity: incrementQuantity,deleteCart: deleteCart);
                      },
                      separatorBuilder: (_, __) =>
                          const SizedBox(
                            height: 16,
                          ),
                      itemCount: cartItems.length,
                    ).paddingSymmetric(horizontal: 16),
                  ),
                  checkoutCard(totalAmount, context)
                ],
              );
            }
            return const SizedBox();
          },
        ));
  }


}