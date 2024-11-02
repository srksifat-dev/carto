import 'package:carto/features/cart/data/models/cart_model.dart';
import 'package:carto/features/cart/domain/repositories/cart_repository.dart';
import 'package:carto/features/cart/presentation/cubits/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartCubit({required this.cartRepository}) : super(CartInitial());

  double totalAmount = 0;
  List<CartModel> cartItems = [];

  Future<void> getAllCarts({required String userId}) async {
    try {
      emit(CartLoading());
      cartItems = await cartRepository.getAllCarts(userId: userId);
      calculateTotalAmount();
      emit(CartLoaded(
        carts: cartItems,
        totalAmount: totalAmount,
      ));
    } catch (error) {
      emit(CartError(error: error.toString()));
    }
  }

  Future<void> addToCart(
      {required CartModel cartItem, required String userId}) async {
    final existingIndex = cartItems.indexWhere(
        (item) => item.product.id.toString() == cartItem.product.id.toString());
    if (existingIndex != -1) {
      final existingItem = cartItems[existingIndex];
      try {
        updateQuantity(
          productId: existingItem.product.id.toString(),
          isIncrement: true,
          userId: userId,
        );
        Fluttertoast.showToast(msg: "Quantity is Updated");
      } catch (error) {
        emit(CartError(error: error.toString()));
      }
    } else {
      try {
        emit(CartLoading());

        cartRepository.addToCart(cartItem: cartItem, userId: userId);
        Fluttertoast.showToast(msg: "The product is added to the cart");
        cartItems.add(cartItem);
        calculateTotalAmount();
        emit(CartLoaded(carts: cartItems, totalAmount: totalAmount));
      } catch (error) {
        emit(CartError(error: error.toString()));
      }
    }
  }

  Future<void> updateQuantity({
    required String productId,
    required bool isIncrement,
    required String userId,
  }) async {
    try {
      final index = cartItems
          .indexWhere((item) => item.product.id.toString() == productId);

      final item = cartItems[index];
      cartRepository.updatedQuantity(
        productId: productId,
        isIncrement: isIncrement,
        userId: userId,
      );
      final updatedItem = item.copyWith(
          quantity: isIncrement
              ? item.quantity++
              : item.quantity > 1
                  ? item.quantity--
                  : item.quantity);
      cartItems[index] = updatedItem;
      calculateTotalAmount();
      emit(CartLoaded(carts: cartItems, totalAmount: totalAmount));
      Fluttertoast.showToast(msg: "Quantity is Updated");
    } catch (error) {
      emit(CartError(error: error.toString()));
    }
  }

  Future<void> deleteCart({required String productId})async{
    try{
      final index = cartItems.indexWhere((item)=> item.product.id.toString() == productId);
      final item = cartItems[index];
      cartRepository.deleteCart(productId: productId);
      cartItems.remove(item);
      calculateTotalAmount();
      emit(CartLoaded(carts: cartItems, totalAmount: totalAmount));
      Fluttertoast.showToast(msg: "Cart is deleted");

    }catch (error){
      emit(CartError(error: error.toString()));
    }
  }

  void calculateTotalAmount() {
    totalAmount = cartItems.fold(0.0,
        (sum, item) => sum + (item.quantity * item.product.price!.toDouble()));
  }
}
