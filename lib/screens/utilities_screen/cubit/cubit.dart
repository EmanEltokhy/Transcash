import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transcash/screens/utilities_screen/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network.dart';

class UtilitiesCubit extends Cubit<UtilitiesStates> {
  UtilitiesCubit() : super(UtilitiesInitialState());

  static UtilitiesCubit get(context) => BlocProvider.of(context);
  List<bool> isSelected = [true, false, false, false];
  List<String> providers = ['electricity', 'gas', 'water'];
  List<String> service = ['North of Cairo', 'South of Cairo'];
  bool noBill = false;
  var codeController = TextEditingController();
  final charges = 2.5;
  double total = 0;
  double amount = 0;
  int index = 0;
  int contentIndex = 0;
  String dropValue = "Select Service Provider";
  int? billID;

  void initial(){
    emit(UtilitiesStartState());
  }

  void changeDropDownValue(value) async {
    dropValue = value;
    emit(ChangeDropDown());
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
    total = amount + charges;
    emit(ChangeContentState());
  }

  void utilitySave(context, {String? visaAmount}) async {
    emit(UtilitiesLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final mobile = prefs.getString('mobile');

    try {
    Map<String, dynamic> data = {
      'account_id': mobile,
      'amount': total.toString(),
      'service_type': dropValue,
      'type': providers[index],
      'payment_code': codeController.text,
    };
    const path = "/services/utilities/";
    final response = await httpRequest(
        data: data,
        token: token,
        path: path);
    final respondedData = jsonDecode(response.body);
    if (response.statusCode >= 400) {
      showToast(text: respondedData.toString(), state: ToastStates.ERROR);
      emit(UtilitiesErrorState());
      return;
    }
    if (respondedData == 'stored') {
      dialog(context);
    }
    emit(UtilitiesSuccessState());
    delete();
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit((UtilitiesErrorState()));
    }
  }

  void billAmount() async {
    emit(BillLoadingState());

    try {
      final Map<String, String> queryParams = {
        'code': codeController.text,
        'type': providers[index],
        'service': dropValue
      };
      const path = "/bill/";
      final response = await getAmount(path: path, queryParams: queryParams);
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        if (respondedData[0] == 'bill not found') {
          noBill = true;
          changeContent();
          return;
        }
        emit(BillErrorState());
        return;
      }

      amount = double.tryParse(respondedData[0]) ?? 0.0;
      billID = respondedData[1];
      emit(BillSuccessState());
      changeContent();
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(BillErrorState());
    }
  }

  void delete() async {
    emit(DeleteLoadingState());

    try {
      final path = '/bill/$billID/';
      final response = await deleteAmount(path:path);
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
          showToast(text: respondedData.toString(), state: ToastStates.ERROR);
          emit(DeleteErrorState());
          return;
        }
      emit(DeleteSuccessState());
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(DeleteErrorState());
    }
  }
}
