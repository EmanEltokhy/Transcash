import 'package:flutter/material.dart';

import '../shared/components/components.dart';

class ProvidersWidget extends StatelessWidget {
  const ProvidersWidget({Key? key, required this.providers, required this.cubit}) : super(key: key);

  final List providers;
  final cubit;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 10.0),
              child: Text(
                'Select Providers',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 25),
              child: Center(
                child: Row(
                  children: [
                    for (var i = 0; i < providers.length; i++)
                      CardItem(
                        image: providers[i]['image']!,
                        text: providers[i]['title']!,
                        onTap: () {
                          cubit.index = i;
                          cubit.changeSelected();
                        },
                        isSelected: cubit.isSelected[i],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
