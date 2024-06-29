import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transcash/screens/transfer_screen/cubit/states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network.dart';

class TransferCubit extends Cubit<TransferStates> {
  TransferCubit() : super(TransferInitialState());

  static TransferCubit get(context) => BlocProvider.of(context);
  List<bool> isSelected = [true];
  List<String> providers = ['Transfer Money'];
  var mobileNumberController = TextEditingController();
  var amountController = TextEditingController();
  final charges = 2.5;
  double total = 0;
  int contentIndex = 0;
  int index = 0;
  String dropValue = "Select Service Provider";

  void changeDropDownValue(value) async {
    dropValue = value;
    emit(ChangeDropDown());
  }

  void changeContent() {
    contentIndex = 1;
    total = double.parse(amountController.text) + charges;
    emit(ChangeContentState());
  }

  void rechargeSave(context,{String? visaAmount}) async {
    emit(TransferLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final mobile = prefs.getString('mobile');
    Map<String, dynamic> data;
    if(visaAmount != null){
      data = {
        'account_id': mobile,
        'amount': visaAmount,
        'mobile_number': mobile,
        'In':true
      };
    }else{
      data = {
        'account_id': mobile,
        'amount': total.toString(),
        'mobile_number': mobileNumberController.text,
        'In':false
      };
    }
    try {
      const path = "/services/transfer/";
      final response = await httpRequest(
          data: data,
          token: token,
          path: path);
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(TransferErrorState());
        return;
      }
      if (respondedData == 'stored') {
        print('before show dialog');
        dialog(context);
      }
      // showToast(text: 'Payed Successfully', state: ToastStates.SUCCESS);
      emit(TransferSuccessState());
      // });
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit((TransferErrorState()));
    }
  }
}
