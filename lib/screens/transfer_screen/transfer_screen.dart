import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcash/screens/transfer_screen/cubit/cubit.dart';
import 'package:transcash/shared/cubit/cubit.dart';
import 'package:transcash/shared/cubit/states.dart';
import 'package:transcash/widgets/card_confirm.dart';

import '../../shared/components/components.dart';
import '../../widgets/card_fileds.dart';
import '../../widgets/service_widget.dart';
import 'cubit/states.dart';

class TransferScreen extends StatelessWidget {
  final GlobalKey<FormFieldState> phoneFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> amountFieldKey = GlobalKey();
  final providers = [
    {'title': 'Transfer Money', 'image': 'assets/images/transfer.jpeg'},
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
          create: (context) => TransferCubit(),
        )
      ],
      child: BlocConsumer<TransferCubit, TransferStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final Transfer = TransferCubit.get(context);
          List<Widget> content = [
            CardFields(
                recharge: Transfer,
                validator: validator,
                amountFieldKey: amountFieldKey,
                phoneFieldKey: phoneFieldKey),
            CardConfirm(recharge: Transfer)
          ];
          List<String> title = ['Next', 'Confirm Payment'];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mobile Transfer'),
            ),
            body: ServiceWidget(
                providers: providers,
                cubit: Transfer,
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
