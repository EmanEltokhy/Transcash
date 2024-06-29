import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcash/screens/login_screen/login_screen.dart';
import 'package:transcash/screens/signin_screen/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var nationalIdController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmedPassController = TextEditingController();

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  bool checkBoxValue = false;


  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = (isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined);

    emit(ChangePasswordVisibilityState());
  }

  void changeCheckBox(value) {
    if (checkBoxValue == true) {
      checkBoxValue = false;
    } else {
      checkBoxValue = true;
    }
    emit(ChangeCheckBoxState());
  }

  void userRegister({
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState());
    try
    {
      const path = "/account/register/";
      Map<String, dynamic> data = {
        'first_name': fNameController.text,
        'last_name': lNameController.text,
        'username': usernameController.text,
        'national_id': nationalIdController.text,
        'mobile_number': phoneNumberController.text,
        'password': confirmedPassController.text,
        'email': emailController.text,
      };
      final response = await homeRequest(
          data: data,
          path: path);
      print(response.body);
      final respondedData = jsonDecode(response.body);
      print('response');
      print(respondedData);
      if(response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(RegisterErrorState());
        return;
      }
      navigate(context, const LoginScreen());
      emit(RegisterSuccessState());
    }
    catch(error){
      print('error');
      print(error.toString());
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(RegisterErrorState());
    }
  }
}
