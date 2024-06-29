import 'package:flutter/material.dart';
import '../model/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0,70,10,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(slideList[index].imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            slideList[index].title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            slideList[index].description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),
          ),
        ],
      ),
    );
  }
}
