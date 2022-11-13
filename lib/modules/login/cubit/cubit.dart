import 'dart:convert';

import 'package:eStore/models/user/user_model.dart';
import 'package:eStore/modules/login/cubit/states.dart';
import 'package:eStore/shared/network/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginStates>
{
  final Repository repository;

  LoginCubit(this.repository) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  userLogin({
    @required String email,
    @required String password,
  })
  {
    repository
        .userLogin(
      email: email,
      password: password,
    )
        .then((value)
    {

      userModel = UserModel.fromJson(value.data);

      if(userModel.status)
      {
        emit(LoginSuccessState(userModel));
      } else
      {
        emit(LoginErrorState(userModel.message));
      }
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
