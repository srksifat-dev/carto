import 'package:carto/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:carto/features/auth/presentation/cubits/auth_state.dart';
import 'package:carto/features/auth/presentation/pages/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shop/presentation/pages/shop_screen.dart';



class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(builder: (context,state){
      if(state is Unauthenticated){
        return AuthScreen();
      }
      if(state is Authenticated){
        return ShopScreen();
      }
      else{
        return Scaffold(body: Center(
          child: CircularProgressIndicator(),
        ),);
      }
    }, listener: (context,state){

    });
  }
}
