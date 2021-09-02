import 'package:flutter/material.dart';

double heightResponsive({
  required BuildContext context,
  required double height,
}) =>
    MediaQuery.of(context).size.height / height;

double widthResponsive({
  required BuildContext context,
  required double width,
}) =>
    MediaQuery.of(context).size.width / width;

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

//SHOW TOAST

Widget defaultTextFormField({
  Color borderColor = const Color(0xFF384A8A),
  Color focusedColor =  Colors.grey,
  Color fontColor = const Color(0xFFEC7C28),
  double fontSize=15,
  required BuildContext context,
  double width = double.infinity,
  double height = 10,
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String messageValidate,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isClickable = true,
  bool isPassword = false,
  bool readOnly = false,
}) =>
    Container(
      width: width == double.infinity
          ? double.infinity
          : widthResponsive(
        context: context,
        width: width,
      ),
      height: heightResponsive(
        context: context,
        height: height,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      child: TextFormField(
        readOnly: readOnly,
        enabled: isClickable,
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        style: TextStyle(
          fontFamily: "GOTHIC",
          fontSize: fontSize,
          color: fontColor,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return messageValidate;
          }
          return null;
        },
        onFieldSubmitted: (value) {
          if (onSubmit != null) {
            onSubmit(value);
          }
        },
        onChanged: (value) {
          if (onChange != null) {
            onChange(value);
          }
        },
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        decoration: InputDecoration(

          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: borderColor,
          //   ),
          // ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusedColor,
            ),
          ),
          labelText: label,

          labelStyle: TextStyle(
            color : fontColor,
          ),
       //   border: OutlineInputBorder(),
        ),
      ),
    );

Widget defaultInkWellContainer({
  required context,
  required String text,
  required Color textColor,
  required Color containerColor,
  required Widget goTo,
}) =>
    InkWell(
      onTap: () {
        navigateTo(
          context,
          goTo,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
          color: containerColor,
        ),
        height: heightResponsive(
          context: context,
          height: 8,
        ),
        width: widthResponsive(
          context: context,
          width: 3.5,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 30.0,
              fontFamily: "AquireBold",
            ),
          ),
        ),
      ),
    );

Widget defaultElevatedButton({
  Function? onPressed,
  required BuildContext context,
  double width = double.infinity,
  double height = 22,
  double borderRadius = 22,
  double letterSpacing = 0,
  required String buttonName,
  double fontSize = 20,
  String fontFamily = 'GOTHIC',
  Color textColor = const Color(0xFF27488C),
  Color primaryColor = const Color(0xFFEEEEEF),
  Color shadowColor = const Color(0xFFEEEEEF),
}) =>
    Container(

      width: width == double.infinity
          ? double.infinity
          : widthResponsive(
        context: context,
        width: width,
      ),
      height: heightResponsive(
        context: context,
        height: height,
      ),

      child: ElevatedButton(
        onPressed: () {
          if(onPressed!=null)
          onPressed();
        },
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),

        ),
      ),
    );
