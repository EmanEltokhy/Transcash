import 'package:flutter/material.dart';

import '../shared/components/components.dart';

class CardConfirm extends StatelessWidget {
  const CardConfirm({Key? key, required this.recharge}) : super(key: key);
  final recharge;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          25.0, 5, 25, 60),
      child: Column(
        children: [
          defaultFormField(
            isClickable: false,
            context: context,
            initialValue: recharge
                .mobileNumberController.text,
            type: TextInputType.phone,
            label: 'Mobile Number',
            prefix: Icons.sim_card,
          ),
          const SizedBox(
            height: 10,
          ),
          defaultFormField(
            context: context,
            isClickable: false,
            type: TextInputType.number,
            initialValue:
            recharge.amountController.text,
            label: 'Amount',
            prefix: Icons.attach_money,
          ),
          const SizedBox(
            height: 10,
          ),
          defaultFormField(
            context: context,
            isClickable: false,
            initialValue: recharge.charges.toString(),
            type: TextInputType.number,
            label: 'Charges',
            prefix: Icons
                .miscellaneous_services_rounded,
          ),
          const SizedBox(
            height: 10,
          ),
          defaultFormField(
            context: context,
            type: TextInputType.number,
            initialValue: recharge.total.toString(),
            isClickable: false,
            label: 'Total',
            prefix: Icons.attach_money,
          ),
        ],
      ),
    );
  }
}
