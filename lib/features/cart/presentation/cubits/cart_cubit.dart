import 'package:carto/core/base/resources/data_state.dart';
import 'package:carto/features/cart/domain/repositories/cart_repository.dart';
import 'package:carto/features/cart/presentation/cubits/cart_state.dart';
import 'package:carto/features/shop/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/cart_entity.dart';

class CartCubit extends Cubit<CartState>{
  final CartRepository cartRepository;

  CartCubit({required this.cartRepository}) : super(CartInitial());

  Future<void> getAllCarts({required String userId})async{
    try{
      emit(CartLoading());
      final carts = cartRepository.getAllCarts(userId: userId);
      emit(CartLoadedDone(carts));
    }catch (error){
      emit(CartError(error.toString()));
    }
  }
  Future<void> addToCart({required CartEntity cartItem, required String userId})async{
    try{
      emit(CartLoading());
      cartRepository.addToCart(cartItem: cartItem, userId: userId);
      Fluttertoast.showToast(msg: "The product is added to the cart");
      emit(CartAdded());
    }catch (error){
      emit(CartError(error.toString()));
    }
  }
  Future<void> updateQuantity({required String productId,
    required int updatedQuantity,
    required String userId})async{
    try{
      if(updatedQuantity > 0){
        emit(CartLoading());
        cartRepository.updatedQuantity(productId: productId, updatedQuantity: updatedQuantity, userId: userId,);
        Fluttertoast.showToast(msg: "Quantity is Updated");
        emit(CartUpdated());
      }else{
        Fluttertoast.showToast(msg: "Quantity must be at least one");
      }

    }catch (error){
      emit(CartError(error.toString()));
    }}
}