import 'package:carto/core/base/resources/data_state.dart';
import 'package:carto/features/shop/domain/entities/product_entity.dart';
import 'package:carto/features/shop/domain/repositories/shop_repository.dart';
import 'package:carto/features/shop/presentation/cubits/shop_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopState>{
  final ShopRepository shopRepository;

  ShopCubit({required this.shopRepository}) : super(ShopInitial());

  Future<void> getProducts()async{
    try{
      emit(ShopLoading());
      final shopDataState = await shopRepository.getProducts();

      if (shopDataState is DataSuccess && shopDataState.data!.isNotEmpty){
        emit(ShopFulfillDone(shopDataState.data!));
      }
      if(shopDataState is DataFailed){
        emit(ShopError(shopDataState.error!.toString()));
      }
    }catch(error){
      emit(ShopError(error.toString()));
    }
  }
  Future<ProductEntity?> getProductById({required String productId})async{
    try{
      final shopDataState = await shopRepository.getProductById(productId: productId);

      if (shopDataState is DataSuccess){
        emit(FindSingleProductById(shopDataState.data!));
      }
      if(shopDataState is DataFailed){
        emit(ShopError(shopDataState.error!.toString()));
      }
    }catch(error){
      emit(ShopError(error.toString()));
    }
  }
}