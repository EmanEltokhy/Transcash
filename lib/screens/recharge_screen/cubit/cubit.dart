import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transcash/screens/recharge_screen/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network.dart';

class RechargeCubit extends Cubit<RechargeStates> {
  RechargeCubit() : super(RechargeInitialState());

  static RechargeCubit get(context) => BlocProvider.of(context);
  List<bool> isSelected = [true, false, false, false];
  List<String> providers = ['Orange', 'Vodafone', 'Etisalat', 'We'];
  var mobileNumberController = TextEditingController();
  var amountController = TextEditingController();
  final charges = 2.5;
  double total = 0;

  int index = 0;
  int contentIndex = 0;

  void initial(){
    emit(RechargeStartState());
  }

  void changeSelected() {
    isSelected.asMap().forEach((i, value) {
      if (i == index) {
        isSelected[i] = !value;
      } else {
        isSelected[i] = false;
      }
    });
    emit(ChangeSelectedState());
  }

  void changeContent() {
    contentIndex = 1;
    total = double.parse(amountController.text) + charges;
    emit(ChangeContentState());
  }

  void rechargeSave(context, {String? visaAmount}) async {
    emit(RechargeLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final mobile = prefs.getString('mobile');

    Map<String, dynamic> data = {
      'amount': total.toString(),
      'mobile_number': mobileNumberController.text,
      'account_id': mobile,
      'service_provider': providers[index],
    };
    const path = "/services/recharge/";

    try {
      final response = await httpRequest(
        data: data,
        token: token,
        path: path,
      );
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(RechargeErrorState());
        return;
      }
      if (respondedData == 'stored') {
        dialog(context);
      }
      emit(RechargeSuccessState());
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(RechargeErrorState());
    }
  }

}