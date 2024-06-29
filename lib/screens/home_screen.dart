import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transcash/shared/cubit/cubit.dart';

import '../shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => UserCubit()..userData(),
        child: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {
            if (state is DashboardState) {
              UserCubit.get(context).userData();
            } else if (state is HistoryState) {
              UserCubit.get(context).transactionsHistory();
            }
          },
          builder: (context, state) {
            final user = UserCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(user.titles[user.currentIndex]),
              ),
              body: user.screens[user.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard), label: 'Dashboard'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.miscellaneous_services_outlined),
                      label: 'Services'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: 'History'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ],
                onTap: user.setIndex,
                currentIndex: user.currentIndex,
              ),
            );
          },
        ));
  }
}
