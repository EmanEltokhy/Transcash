import 'package:flutter/material.dart';

import 'package:transcash/screens/recharge_screen/recharge_screen.dart';
import 'package:transcash/screens/transfer_screen/transfer_screen.dart';
import 'package:transcash/screens/utilities_screen/utilities_screen.dart';

import '../shared/components/components.dart';
import 'donation_screen/donation_screen.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
    final services = [
    {'title': 'Mobile Recharge', 'image': 'assets/images/mobil-recharge.png'},
    {'title': 'Home Internet', 'image': 'assets/images/home-internet.png'},
    {'title': 'Cash In & Cash Out', 'image': 'assets/images/cash.jpg'},
    {'title': 'Money Transfer', 'image': 'assets/images/transaction.png'},
    {'title': 'Utilities', 'image': 'assets/images/utilities.png'},
    {'title': 'Donation', 'image': 'assets/images/donation.png'},
  ];
    final List<Widget> screens = [RechargeScreen(),RechargeScreen(),RechargeScreen(),TransferScreen(),UtilitiesScreen(),DonationScreen()];
    int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.only(left: 10, top: 60, right: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20),
        children: [
          for (int i=0;i<services.length;i++)
            ServiceCard(
              title: services[i]['title']!,
              imageAsset: services[i]['image']!,
              onTap: (){
                navigate(context, screens[i]);
              },
            )
        ],
      )
    );
  }
}