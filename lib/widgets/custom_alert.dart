import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_jack/resources/colors.dart';
import 'package:hungry_jack/widgets/custom_button.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({Key? key, this.title, this.body, this.btnText, this.onTap})
      : super(key: key);
  final String? title;
  final String? body;
  final String? btnText;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? "",
        style:  GoogleFonts.anton(
            textStyle: const TextStyle(
                fontSize: 18,
                color: AppColors.black)),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            body ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.black),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CustomButton(
                textSize: 15,
                textColor: AppColors.white,
                borderRadius: 15,
                verticalPadding: 10,
                backgroundColor: AppColors.red,
                btnText: btnText ?? "Ok",
                onTap: () {
                  onTap != null ? onTap!() : {};
                }),
          )
        ],
      )),
    );
  }
}
