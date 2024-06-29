import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transcash/screens/home_screen.dart';
import 'package:transcash/shared/components/components.dart';
import '../../../shared/network.dart';
import './states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  var nationalController = TextEditingController();
  var passwordController = TextEditingController();

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required BuildContext context,
}) async {
    emit(LoginLoadingState());
    try
    {
      const path = "/account/api/login/";
      Map<String, dynamic> data = {
        'national_id': nationalController.text,
        'password': passwordController.text,
      };
      final response = await httpRequest(
          data: data,
          token: '',
          path: path);
      final respondedData = jsonDecode(response.body);
      if(response.statusCode >= 400) {
        showToast(text: respondedData['detail'], state: ToastStates.ERROR);
        emit(LoginErrorState());
        return;
      }
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('Token', respondedData['access']);
        navigate(context, const HomeScreen());
        emit(LoginSuccessState());
      });
    }
    catch(error){
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(LoginErrorState());
    }
}


  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    (isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined);
    emit(ChangePasswordVisibilityState());
  }

}