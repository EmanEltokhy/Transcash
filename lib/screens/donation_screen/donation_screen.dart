import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcash/screens/donation_screen/cubit/cubit.dart';
import 'package:transcash/screens/donation_screen/cubit/states.dart';
import 'package:transcash/widgets/card_confirm.dart';

import '../../widgets/card_fileds.dart';
import '../../widgets/service_widget.dart';

class DonationScreen extends StatelessWidget {
  DonationScreen({this.name, key}) : super(key: key);
  final name;
  final GlobalKey<FormFieldState> phoneFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> amountFieldKey = GlobalKey();
  final providers = [
    {'title': 'El Helal El Ahmar El Masry', 'image': 'assets/images/helal.jpg'},
    {'title': '57357', 'image': 'assets/images/57.png'},
    {'title': 'Resala', 'image': 'assets/images/resala.png'},
    {'title': 'Bet El-Zakat', 'image': 'assets/images/bet.png'},
  ];

  String? validator(value) {
    if (value.isEmpty) {
      return 'Must not be Empty!!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DonationCubit()..initial(),
      child: BlocConsumer<DonationCubit, DonationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final recharge = DonationCubit.get(context);
          if(state is DonationStartState)
          {
            int index = providers.indexWhere((element) => element['title'] == name);
            if(index != 0 && index != -1) {
              recharge.index = index;
              recharge.changeSelected();
            }
          }
          List<Widget> content = [
            CardFields(
                recharge: recharge,
                validator: validator,
                amountFieldKey: amountFieldKey,
                phoneFieldKey: phoneFieldKey),
            CardConfirm(recharge: recharge)
          ];
          List<String> title = ['Next', 'Confirm Payment'];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Donation'),
            ),
            body: ServiceWidget(
                providers: providers,
                cubit: recharge,
                amountFieldKey: amountFieldKey,
                content: content,
                phoneFieldKey: phoneFieldKey,
                title: title),
          );
        },
      ),
    );
  }
}
