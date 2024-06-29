import 'package:flutter/material.dart';
import 'package:transcash/screens/home_screen.dart';
import 'package:transcash/widgets/providers_widget.dart';
import '../shared/components/components.dart';
import 'package:giff_dialog/giff_dialog.dart';

enum PaymentOption { visa, account }

class ServiceWidget extends StatelessWidget {
  ServiceWidget({
    Key? key,
    required this.providers,
    required this.cubit,
    required this.content,
    required this.title,
    required this.phoneFieldKey,
    required this.amountFieldKey,
  }) : super(key: key);
  final List providers;
  final cubit;
  final List<Widget> content;
  final List<String> title;
  final GlobalKey<FormFieldState> phoneFieldKey;
  final GlobalKey<FormFieldState> amountFieldKey;

  PaymentOption _selectedOption = PaymentOption.visa;

  // void showPaymentOptions(BuildContext context) {
  //   final key = GlobalKey();
  //   BuildContext parent = context;
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         key: key,
  //         builder: (BuildContext context, StateSetter setState) {
  //           return Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Text('Pay From', textAlign: TextAlign.center, style: TextStyle(color: Colors.teal),),
  //                 SizedBox(height: 8,),
  //                 ListTile(
  //                   leading: const Icon(Icons.credit_card),
  //                   trailing: CircleAvatar(
  //                     radius: 16,
  //                     backgroundColor: _selectedOption == PaymentOption.visa
  //                         ? Theme.of(context)
  //                             .colorScheme!
  //                             .primary // Checkmark color when selected
  //                         : Colors.transparent,
  //                     child: Icon(
  //                       Icons.check,
  //                       color: _selectedOption == PaymentOption.visa
  //                           ? Colors.white // Checkmark color when selected
  //                           : Colors
  //                               .transparent, // Hide checkmark when unselected
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     setState(() {
  //                       _selectedOption = PaymentOption.visa;
  //                     });
  //                     Navigator.pop(context);
  //                     cubit.rechargeSave(parent, visa: true);
  //                   },
  //                   title: const Text('Visa'),
  //                 ),
  //                 ListTile(
  //                     leading: Icon(Icons.account_balance),
  //                     trailing: CircleAvatar(
  //                       radius: 16,
  //                       backgroundColor:
  //                           _selectedOption == PaymentOption.account
  //                               ? Theme.of(context)
  //                                   .colorScheme!
  //                                   .primary // Checkmark color when selected
  //                               : Colors.transparent,
  //                       child: Icon(
  //                         Icons.check,
  //                         color: _selectedOption == PaymentOption.account
  //                             ? Colors.white // Checkmark color when selected
  //                             : Colors
  //                                 .transparent, // Hide checkmark when unselected
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       setState(() {
  //                         _selectedOption = PaymentOption.account;
  //                       });
  //                       Navigator.pop(context);
  //                       cubit.rechargeSave(parent, visa: false);
  //                     },
  //                     title: const Text('Account')),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    return Padding(
      // key: key,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
      child: Column(
        key: key,
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProvidersWidget(providers: providers, cubit: cubit),
                  const SizedBox(height: 40),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 0, 10.0),
                          child: Text(
                            cubit.providers[cubit.index],
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        content[cubit.contentIndex]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: defaultButton(
              double.infinity,
              60.0,
              title[cubit.contentIndex],
              true,
              () {
                if (cubit.contentIndex == 0) {
                  if (phoneFieldKey.currentState!.validate() &&
                      amountFieldKey.currentState!.validate()) {
                    cubit.changeContent();
                  }
                } else {
                  cubit.rechargeSave(context);
                }
                // Handle button click action here.
              },
              context,
            ),
          ),
        ],
      ),
    );
  }
}
