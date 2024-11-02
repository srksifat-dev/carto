import 'package:carto/core/utils/extensions/screen_size_extension.dart';
import 'package:carto/core/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../data/models/cart_model.dart';

Card cartCard({
  required CartModel cart,
  required BuildContext context,
  required void Function(int oldQuantity) decrementQuantity,
  required void Function(int oldQuantity) incrementQuantity,
  required void Function(String productId) deleteCart,
}) {
  return Card(
    child: Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cart.product.image!),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 100,
          width: context.screenWidth * 62,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      cart.product.title!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20,),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () => deleteCart(cart.product.id.toString()),
                      child: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.error,
                      )),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      text: "\$${cart.product.price}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,),
                      children: [
                        TextSpan(
                            text: " x${cart.quantity}",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => decrementQuantity(cart.quantity),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 48,
                        child: Center(
                          child: Text(
                            "${cart.quantity}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ).paddingSymmetric(horizontal: 8),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => incrementQuantity(cart.quantity),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    ).padding(all: 8),
  );
}
