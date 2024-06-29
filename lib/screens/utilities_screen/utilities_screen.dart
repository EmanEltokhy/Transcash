import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../shared/components/components.dart';
import '../../widgets/providers_widget.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

enum PaymentOption { visa, account }

class UtilitiesScreen extends StatelessWidget {
  UtilitiesScreen({this.name, key}) : super(key: key);
  final name;
  final GlobalKey<FormFieldState> codeFieldKey = GlobalKey();
  final providers = [
    {'title': 'Electricity', 'image': 'assets/images/elect.png'},
    {'title': 'Gas', 'image': 'assets/images/gas.png'},
    {'title': 'Water', 'image': 'assets/images/water.png'}
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
      create: (context) => UtilitiesCubit()..initial(),
      child: BlocConsumer<UtilitiesCubit, UtilitiesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final utility = UtilitiesCubit.get(context);
          if(state is UtilitiesStartState)
          {
            int index = providers.indexWhere((element) => element['title'] == name);
            if(index != 0 && index != -1) {
              utility.index = index;
              utility.changeSelected();
            }
          }
          List<Widget> content = [
            CardFields(
              cubit: utility,
              validator: validator,
              codeFieldKey: codeFieldKey,
            ),
            CardConfirm(cubit: utility)
          ];
          List<String> title = ['Next', 'Confirm Payment'];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Utilities'),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: double.infinity,
                              child: ProvidersWidget(
                                  providers: providers, cubit: utility)),
                          const SizedBox(height: 40),
                          Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15, 20, 0, 10.0),
                                  child: Text(
                                    utility.providers[utility.index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ),
                                content[utility.contentIndex]
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (BuildContext context) => utility.noBill,
                    widgetBuilder: (BuildContext context) => Container(),
                    fallbackBuilder: (BuildContext context) => Expanded(
                      child: defaultButton(
                        double.infinity,
                        60.0,
                        title[utility.contentIndex],
                        true,
                        () {
                          if (utility.contentIndex == 0) {
                            if (codeFieldKey.currentState!.validate() &&
                                utility.dropValue !=
                                    'Select Service Provider') {
                              utility.billAmount();
                            }
                          } else {
                            utility.utilitySave(context);
                          }
                          // Handle button click action here.
                        },
                        context,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardFields extends StatelessWidget {
  const CardFields(
      {Key? key,
      required this.cubit,
      required this.codeFieldKey,
      required this.validator})
      : super(key: key);
  final cubit;
  final GlobalKey<FormFieldState> codeFieldKey;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 5, 25, 60),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(cubit.dropValue),
                  onChanged: cubit.changeDropDownValue,
                  items: [
                    for (final service in cubit.service)
                      DropdownMenuItem<String>(
                        value: service,
                        child: Text(service),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            defaultFormField(
                context: context,
                controller: cubit.codeController,
                type: TextInputType.number,
                validate: validator,
                label: 'Payment Code',
                prefix: Icons.wifi_tethering_rounded,
                key: codeFieldKey),
          ],
        ));
  }
}

class CardConfirm extends StatelessWidget {
  const CardConfirm({Key? key, required this.cubit}) : super(key: key);

  final cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 5, 25, 60),
        child: Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => cubit.noBill,
          widgetBuilder: (BuildContext context) => const SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'No Bill Found !!',
                  style: TextStyle(fontSize: 25),
                ),
              )),
          fallbackBuilder: (BuildContext context) => Column(
            children: [
              defaultFormField(
                isClickable: false,
                context: context,
                initialValue: cubit.dropValue,
                type: TextInputType.phone,
                label: 'Service Type',
                prefix: Icons.account_tree,
              ),
              const SizedBox(
                height: 10,
              ),
              defaultFormField(
                context: context,
                isClickable: false,
                type: TextInputType.number,
                initialValue: cubit.codeController.text,
                label: 'Payment Code',
                prefix: Icons.attach_money,
              ),
              const SizedBox(
                height: 10,
              ),
              defaultFormField(
                context: context,
                isClickable: false,
                initialValue: cubit.amount.toString(),
                type: TextInputType.number,
                label: 'Payment Amount',
                prefix: Icons.miscellaneous_services_rounded,
              ),
              const SizedBox(
                height: 10,
              ),
              defaultFormField(
                context: context,
                isClickable: false,
                initialValue: cubit.charges.toString(),
                type: TextInputType.number,
                label: 'Charges',
                prefix: Icons.miscellaneous_services_rounded,
              ),
              const SizedBox(
                height: 10,
              ),
              defaultFormField(
                context: context,
                type: TextInputType.number,
                initialValue: cubit.total.toString(),
                isClickable: false,
                label: 'Total',
                prefix: Icons.attach_money,
              ),
            ],
          ),
        ));
  }
}
