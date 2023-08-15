import 'package:flutter/material.dart';

//import 'dart:html';

Widget defaultTextButton({
  required function,
  required dynamic text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultButton({
  double width = 300,
  //double.infinity,
  Color background = Colors.green,
  bool isUpperCase = true,
  required BuildContext context,
  double radius = 3.0,
  required Widget screen,
  function,
  required dynamic text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          navto(context, screen);
        },
        // function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void navto(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  double width = 300,

  // Function onChange,
  //Function onTap,
  bool isPassword = false,
  required validate,
  required dynamic label,
}) =>
    SizedBox(
      width: 300,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(
          color: Colors.black,
        ),
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget fullDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

////////////////////BUTTTON
class DefaultButton extends StatelessWidget {
  Function onPress;
  String text;
  IconData? icon;
  double? borderRadius;
  double? height;
  Color? backgroundColor;
  Color? textColor;
  bool hasBorder;

  DefaultButton({Key? key, required this.onPress, required this.text, this.icon, this.borderRadius, this.height, this.backgroundColor, this.textColor, this.hasBorder = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 5), color: backgroundColor ?? Colors.green, border: hasBorder ? Border.all(color: Colors.green, width: 1) : null),
        child: MaterialButton(
          onPressed: () {
            onPress();
          },
          minWidth: double.infinity,
          textColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
              ),
              // if (icon != null) Icon(icon, color: Colors.white)
            ],
          ),
        ));
  }
}

////////////////////////////NAV
class NavigationUtils {
  static void navigateTo({
    required BuildContext context,
    required Widget destinationScreen,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationScreen),
      );

  static void navigateToWithCallback({
    required BuildContext context,
    required Widget destinationScreen,
    required VoidCallback callback,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => destinationScreen,
      ),
    ).then(
      (value) => callback(),
    );
  }

  static void navigateAndClearStack({
    required BuildContext context,
    required Widget destinationScreen,
  }) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => destinationScreen,
        ),
        (Route<dynamic> route) => false,
      );

  static void navigateBack({
    required BuildContext context,
  }) {
    FocusScope.of(context).unfocus();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}

/////////////////pincode
