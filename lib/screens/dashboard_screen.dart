import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:transcash/screens/recharge_screen/recharge_screen.dart';
import 'package:transcash/screens/transfer_screen/transfer_screen.dart';
import 'package:transcash/screens/utilities_screen/utilities_screen.dart';
import 'package:transcash/shared/cubit/cubit.dart';
import 'package:transcash/shared/cubit/states.dart';
import '../shared/components/components.dart';
import '../widgets/history_widget.dart';
import 'donation_screen/donation_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final user = UserCubit.get(context);
        return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
                state is DataLoadingState || state is OverviewLoadingState,
            widgetBuilder: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(),
                ),
            fallbackBuilder: (BuildContext context) => SafeArea(
                  child: Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('assets/images/logoo.png',
                                    width: 40, height: 40),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Hi, ${user.customer.username}!',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const Spacer(),
                                if(user.customer.accounts.length != 0)
                                  DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: user.dropValue,
                                    onChanged: (value) {
                                      user.changeDropDownValue(value, context);
                                    },
                                    items: [
                                      for (final mobile
                                          in user.customer.accounts.keys)
                                        DropdownMenuItem<String>(
                                          value: mobile,
                                          child: Text(mobile),
                                        ),
                                      if(user.customer.accounts.length < 3)
                                         const DropdownMenuItem<String>(
                                          value: 'new',
                                          child: Text(
                                            'Add New Account',
                                            style: TextStyle(color: Colors.teal),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Card(

                              margin: const EdgeInsets.all(0),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      const Color(0xFF80CBC4),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Stack(
                                  children: [
                                    Opacity(
                                      opacity: 0.4,
                                      child: Image.asset(
                                          'assets/images/money.png',
                                          alignment: Alignment.centerRight,
                                          fit: BoxFit.contain,
                                          width: double.infinity,
                                          height: 170,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Positioned(
                                      top: 35,
                                      child: Text(
                                        'Balance',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 55,
                                      child: Text(
                                          'EGP ${user.customer.accounts[user.dropValue]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background)),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          showDialogs(
                                              context: context,
                                              title: 'Bank Account Recharge',
                                              label: 'Recharge Amount',
                                              controller: user.amountController,
                                              okFn: () {
                                                user.addMoney(context);
                                                // Navigator.of(context).pop();
                                              });
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Colors
                                                  .white), // Change the color to your desired background color
                                          side: MaterialStateProperty
                                              .all<BorderSide>(const BorderSide(
                                                  color: Colors
                                                      .teal)), // Optional: Change the border color
                                        ),
                                        child: Text('Recharge',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            if (user.recommended.length != 0)
                              Text(
                              'Recommended Services',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (user.recommended.length != 0)
                              SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var i = 0;
                                      i < user.recommended.length;
                                      i++)
                                    DashboardServiceCard(
                                      title: '${user.recommended[i]['name']}',
                                      imageAsset:
                                          'assets/images/${user.getImageForCompany(user.images, user.recommended[i]['name'])}',
                                      onTap: () {
                                        switch (user.recommended[i]
                                            ['category']) {
                                          case 'recharge':
                                            navigate(
                                                context,
                                                RechargeScreen(
                                                    name: user.recommended[i]
                                                        ['name']));
                                            break;
                                          case 'donation':
                                            navigate(
                                                context,
                                                DonationScreen(
                                                    name: user.recommended[i]
                                                        ['name']));
                                            break;
                                          case 'utilities':
                                            navigate(
                                                context,
                                                UtilitiesScreen(
                                                    name: user.recommended[i]
                                                        ['name']));
                                            break;
                                          case 'transfer':
                                            navigate(context, TransferScreen());
                                            break;
                                        }
                                      },
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              // height: 100,
                              padding: const EdgeInsets.all(16.0),

                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: HistoryWidget(
                                historyList: user.overviewTransactions,
                                height: 300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
      },
    );
  }
}
