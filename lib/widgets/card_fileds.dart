import 'package:flutter/material.dart';
import '../shared/components/components.dart';

class CardFields extends StatelessWidget {
  const CardFields({Key? key, required this.recharge, required this.validator, required this.amountFieldKey, required this.phoneFieldKey}) : super(key: key);
  final recharge;
  final String? Function(String?) validator;
  final GlobalKey<FormFieldState<dynamic>>? phoneFieldKey;
  final GlobalKey<FormFieldState<dynamic>>? amountFieldKey;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          25.0, 5, 25, 60),
      child: Column(
        children: [
          defaultFormField(
              context: context,
              controller: recharge
                  .mobileNumberController,
              type: TextInputType.phone,
              label: 'Mobile Number',
              validate: validator,
              prefix: Icons.sim_card,
              key: phoneFieldKey
          ),
          const SizedBox(height: 30,),
          defaultFormField(
              context: context,
              controller: recharge.amountController,
              type: TextInputType.number,
              validate: validator,
              label: 'Amount',
              prefix: Icons.attach_money,
              key: amountFieldKey
          ),
        ],
      ),
    );
  }
}
