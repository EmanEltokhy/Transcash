import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcash/screens/recharge_screen/cubit/cubit.dart';
import 'package:transcash/screens/recharge_screen/cubit/states.dart';
import 'package:transcash/shared/cubit/cubit.dart';
import 'package:transcash/shared/cubit/states.dart';
import 'package:transcash/widgets/card_confirm.dart';

import '../../shared/components/components.dart';
import '../../widgets/card_fileds.dart';
import '../../widgets/service_widget.dart';
// import 'cubit/states.dart';


class RechargeScreen extends StatelessWidget {
  RechargeScreen({this.name, key}) : super(key: key);
  final name;
  final GlobalKey<FormFieldState> phoneFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> amountFieldKey = GlobalKey();
  final providers = [
    {'title': 'Orange', 'image': 'assets/images/orange.png'},
    {'title': 'Vodafone', 'image': 'assets/images/vodafone.png'},
    {'title': 'Etisalat', 'image': 'assets/images/etisalat.png'},
    {'title': 'We', 'image': 'assets/images/we.png'},
  ];

  String? validator(value) {
    if (value.isEmpty) {
      return 'Must not be Empty!!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()..userData()),
        BlocProvider(
          create: (context) => RechargeCubit()..initial(),
        )
      ],
      child: BlocConsumer<RechargeCubit, RechargeStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          final recharge = RechargeCubit.get(context);
          if(state is RechargeStartState)
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
              title: const Text('Mobile Recharge'),
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
