import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key, required this.historyList, required this.height}) : super(key: key);
  final historyList;
  final double height;
  @override
  Widget build(BuildContext context) {
    double heightt = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: heightt*0.004,
        ),
        Text(
          'Transactions Overview',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(
            fontSize: 20,
              color: Theme.of(context)
                  .colorScheme
                  .onBackground),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: heightt*0.5,
          child:
          historyList.isEmpty?
          Center(child: Text('No Transactions yet')):ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: Text(
                  historyList[index]['type'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground),
                ),
                trailing: Text(historyList[index]['In']?
                  '+${historyList[index]['amount']} EGP':'-${historyList[index]['amount']} EGP',
                  style: historyList[index]['In']? Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.green):Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red),
                ),
                subtitle: Text(
                  'Date: ${historyList[index]['date']}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
