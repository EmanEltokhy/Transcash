import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:transcash/screens/home_screen.dart';

Widget defaultButton(width, height, text, arrow, fn, context) => TextButton(
    onPressed: fn,
    child: Container(
      width: width,
      height: height,
      alignment: AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              const Color(0xFF80CBC4),
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.background),
          ),
          const SizedBox(
            width: 20,
          ),
          if (arrow) ...[
            Icon(Icons.arrow_forward,
                color: Theme.of(context).colorScheme.background)
          ] else
            Icon(Icons.logout_outlined,
                color: Theme.of(context).colorScheme.background),
        ],
      ),
    ));

class ServiceCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onTap;

  const ServiceCard({
    key,
    required this.title,
    required this.imageAsset,
    required this.onTap
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            imageAsset,
            fit: BoxFit.contain,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme
                .of(context)
                .colorScheme
                .primary),
          ),
        ]),
      ),
    );
  }
}
class DashboardServiceCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onTap;

  const DashboardServiceCard({
    key,
    required this.title,
    required this.imageAsset,
    required this.onTap
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 190,
        child: Card(
          color: Colors.teal[50],
          elevation: 4,
          shadowColor: Colors.black,
          margin: const EdgeInsets.only(left: 10, bottom: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 10,),
              Image.asset(
                imageAsset,
                fit: BoxFit.contain,
                width: 60,
                height: 60,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String image;
  final String text;
  final bool isSelected;
  final Function() onTap;

  const CardItem({key,required this.image,
    required this.text,
    required this.onTap,
    required this.isSelected}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 140,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.teal : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme
                    .of(context)
                    .colorScheme
                    .background,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  width: 70,
                  height: 70,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 70,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardHistory extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;

  const CardHistory({
    key,
    required this.text,
    required this.onTap,
    required this.isSelected}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Theme
                      .of(context)
                      .colorScheme
                      .primary : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
                color: Theme
                    .of(context)
                    .colorScheme
                    .background,
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}

Widget defaultFormField({
  required BuildContext context,
  TextEditingController? controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  String? Function(String?)? validate,
  required String label,
  void Function()? suffixPressed,
  var prefix,
  var style,
  IconData? suffix,
  bool isClickable = true,
  GlobalKey<FormFieldState>? key,
  FloatingLabelBehavior? floatingLabelBehavior,
  String? initialValue,
}) =>
    TextFormField(
      style: style,
      initialValue: initialValue,
      controller: controller,
      keyboardType: type,
      key: key,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        prefixIcon: prefix != null? Icon(prefix, color: Colors.black):null,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: Colors.black,
                ),
              )
            : null,
      ),
    );

void navigate(
  context,
  widget,
) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}


void dialog(BuildContext ctx) {
  final key = GlobalKey();
  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return NetworkGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Colors.teal,
        key: key,
        image: Image.network(
          "https://i.pinimg.com/originals/4a/10/e3/4a10e39ee8325a06daf00881ac321b2f.gif",
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.topLeft,
        title: const Text(
          'Successful Transaction',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        onOkButtonPressed: () {
          navigate(context, const HomeScreen());
        },
      );
    },
  );
}
void failedDialog(BuildContext ctx) {
  final key = GlobalKey();
  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return NetworkGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Colors.red,
        key: key,
        image: Image.asset(
          "assets/images/error.gif",
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.topLeft,
        title: const Text(
          'Failed Transaction',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        onOkButtonPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    },
  );
}
Future<void> showDialogs(
    {required BuildContext context, required title, required label, required okFn, required controller}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: defaultFormField(context: context,label: label, type: TextInputType.number, controller: controller),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel',style: TextStyle(color: Colors.grey),),
          ),TextButton(
            onPressed: okFn,
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
