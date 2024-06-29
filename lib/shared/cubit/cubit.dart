import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transcash/model/customer.dart';
import 'package:transcash/screens/dashboard_screen.dart';
import 'package:transcash/screens/getting_started_screen.dart';
import 'package:transcash/screens/profile_screen.dart';
import 'package:transcash/screens/services_screen.dart';
import '../../../shared/components/components.dart';
import '../../screens/history_screen.dart';
import '../../screens/paymob.dart';
import '../cubit/states.dart';
import '../network.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialState());

  List<String> titles = ['Dashboard', 'Services', 'History','Profile'];
  List<Widget> screens = [
    const DashboardScreen(),
    ServicesScreen(),
    const HistoryScreen(),
    profileScreen(),
  ];
  Customer customer = Customer.empty();
  String dropValue='';
  List<dynamic> overviewTransactions = [];
  List<dynamic> historyTransactions = [];
  List<dynamic> recommended = [];
  List<Map<String, String>> images = [{'Orange':'orange.png'}, {'Vodafone': 'vodafone.png'},{'Etisalat':'etisalat.png'},
    {'We':'we.jpg'},{'57357':'57.png'},{'Bet El-Zakat':'bet.png'},{'El Helal El Ahmar El Masry':'helal.jpg'},{'Resala':'resala.png'},
    {'Electricity':'elect.png'},{'Gas':'gas.png'},{'Water':'water.png'}];
  List<String> providers = ['Recharge', 'Donation', 'Bill', 'Transfer'];
  List<dynamic> filtered = [];
  List<bool> isSelected = [false, false, false, false];
  bool isFiltered = false;
  var amountController = TextEditingController();
  var newAccountController = TextEditingController();
  int index = 0;

  // bottom Navigator
  int currentIndex = 0;

  static UserCubit get(context) => BlocProvider.of(context);

  void changeSelected() {
    isSelected.asMap().forEach((i, value) {
      if (i == index) {
        isSelected[i] = !value;
        if (!value) {
          isFiltered = true;
          return;
        }
        isFiltered = false;
        return;
      }
      isSelected[i] = false;
    });
    changeData();
    emit(ChangeSelectedState());
  }

  void changeData() {
    final newList = historyTransactions
        .where((element) => element['type'].contains(providers[index]))
        .toList();
    filtered = newList;
    emit(ChangeDataState());
  }

  void setIndex(index) {
    currentIndex = index;
    emit(ChangeIndex());
    if (index == 0) {
      emit(DashboardState());
    } else if (index == 2) {
      emit(HistoryState());
    }
  }

  void changeDropDownValue(value,context) async {
    if(value == 'new'){
      newAccountController.text='';
      showDialogs(context: context,title: 'Add New Account',label: 'Mobile Number',controller: newAccountController, okFn: () {
        if(customer.accounts.length < 3) {
          addAccount(context: context);
        }
        // user.addMoney(context);
        // Navigator.of(context).pop();
      });
    }
    else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('mobile', value);
      dropValue = value;
      emit(ChangeDropDown());
      transactionsOverview();
      recommendedServices();
    }
  }

  void userData() async {
    emit(DataLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');

    try {
      const path = '/account/api/profile/';
      final response = await getRequest(path: path, token: token);
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(DataErrorState());
        return;
      }
      Map<String, String> accounts = {};
      for (final i in respondedData['user']) {
        final account = {i['mobile_number'] as String: i['balance'] as String};
        accounts.addAll(account);
      }
      customer = Customer(
          id: respondedData['id'].toString(),
          fName: respondedData['first_name'],
          lName: respondedData['last_name'],
          username: respondedData['username'],
          nationalId: respondedData['national_id'],
          email: respondedData['email'],
          accounts: accounts);
      final mobile = prefs.getString('mobile');
      if (mobile != null) {
        dropValue = mobile;
      } else {
        dropValue = customer.accounts.keys.first;
      }
      prefs.setString('mobile', dropValue);
      emit(DataSuccessState());
      transactionsOverview();
      recommendedServices();
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(DataErrorState());
    }
  }

  void transactionsOverview() async {
    emit(OverviewLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final mobile = prefs.getString('mobile');
    final Map<String, String> queryParams = {
      'mobile': mobile!,
    };

    try {
      const path = "/account/api/overview/";
      final response =
          await getRequest(path: path, token: token, queryParams: queryParams);
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(OverviewErrorState());
        return;
      }
      // List<dynamic> dataList = respondedData;
      // dataList.sort((a, b) => b["date"].compareTo(a["date"]));
      // dataList = dataList.sublist(0, 4);
      overviewTransactions = respondedData;
      emit(OverviewSuccessState());
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(OverviewErrorState());
    }
  }

  void recommendedServices() async {
    emit(RecommendedLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final mobile = prefs.getString('mobile');
    final Map<String, String> queryParams = {
      'id': mobile!,
    };

    try {
      const path = "/account/api/recommendations/";
      final response =
      await getRequest(path: path, token: token, queryParams: queryParams);
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(OverviewErrorState());
        return;
      }
      recommended = respondedData;
      print('recommended');
      print(recommended);
      emit(RecommendedSuccessState());
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(RecommendedErrorState());
    }
  }

  String getImageForCompany(List<Map<String, String>> list, String companyName) {
    Map<String, String>? result = list.firstWhere(
          (element) {
            return element.keys.first.toLowerCase() == companyName.toLowerCase();
          },
      orElse: () => {},
    );
    if (result.isNotEmpty) {
      return result.values.first;
    } else {
      return 'Company not found';
    }
  }

  void transactionsHistory() async {
    emit(HistoryLoadingState());
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');
    final mobile = prefs.getString('mobile');

    try {
      final Map<String, String> queryParams = {
        'mobile': mobile!,
      };
      const path = "/account/api/history/";
      final response =
          await getRequest(path: path, token: token, queryParams: queryParams);
      final respondedData = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(HistoryErrorState());
        return;
      }
      // List<dynamic> dataList = respondedData;
      // dataList.sort((a, b) => b["date"].compareTo(a["date"]));
      historyTransactions = respondedData;
      emit(HistorySuccessState());
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(HistoryErrorState());
    }
  }

  void addMoney(context) async {
    BuildContext? currentContext = context;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token');

    final Map<String, String> queryParams = {
      'amount': amountController.text,
    };
    const path = "account/api/paymob/";

    try {
      await getRequest(
        token: token,
        path: path,
        queryParams: queryParams,
      ).then((value) {
        final response = jsonDecode(value.body);
        if(currentContext != null) {
          print('before navigate to paymob');
          Navigator.push(
            currentContext,
            MaterialPageRoute(builder: (context) => PaymobWebView(url: response,)),
          );
          amountController.text = '';
        }
      });
    } catch (error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
    }
  }

  void addAccount({
    required BuildContext context,
  }) async {
    emit(AddAccountLoadingState());
    try
    {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token');
      const path = "/account/addAccount/";
      Map<String, dynamic> data = {
        'user': int.tryParse(customer.id),
        'mobile_number': newAccountController.text,
        'balance': 0,
      };
      final response = await httpRequest(
          data: data,
          token: token,
          path: path);
      final respondedData = jsonDecode(response.body);
      if(response.statusCode >= 400) {
        showToast(text: respondedData.toString(), state: ToastStates.ERROR);
        emit(AddAccountErrorState());
        return;
      }
      Navigator.pop(context);
      emit(AddAccountSuccessState());
    }
    catch(error){
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(AddAccountErrorState());
    }
  }

  void logout(context) {
    SharedPreferences.getInstance().then((value) => value.clear());
    navigate(context, const GettingStartedScreen());
    emit(LogoutState());
  }
}
