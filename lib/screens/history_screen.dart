import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:transcash/shared/cubit/cubit.dart';
import 'package:transcash/shared/cubit/states.dart';
import 'package:transcash/widgets/history_widget.dart';
import '../shared/components/components.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double height = MediaQuery.of(context).size.height;
        final user = UserCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                margin: const EdgeInsets.all(0),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i = 0; i < user.providers.length; i++)
                          CardHistory(
                            text: user.providers[i],
                            onTap: () {
                              user.index = i;
                              user.changeSelected();
                            },
                            isSelected: user.isSelected[i],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height*0.02,
              ),
              Container(
                width: double.infinity,
                height: height*0.64,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(12.0)),
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (context)=> user.isFiltered,
                  widgetBuilder: (context) => user.filtered.isEmpty? const Center(child: Text('No Content')):HistoryWidget(historyList: user.filtered, height: 500,),
                  fallbackBuilder: (context) => state is HistorySuccessState?HistoryWidget(historyList: user.historyTransactions, height: 500,):const Center(
                    child: CircularProgressIndicator(),
                  ),


                )
              )
            ],
          ),
        );
      },
    );
  }
}
