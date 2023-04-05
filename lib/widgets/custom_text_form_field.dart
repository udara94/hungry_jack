import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../resources/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.controller,
      this.onChanged,
      this.validationMsg,
      this.hintTextVal,
        this.description,
      required this.text})
      : super(key: key);
  final TextEditingController? controller;
  final Function? onChanged;
  final String? validationMsg;
  final String? hintTextVal;
  final String text;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Text(
          text,
          style: const TextStyle(color: AppColors.ash),
        ),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            onChanged: (val) {
              if (onChanged != null) {
                onChanged!();
              }
            },
            controller: controller,
            validator: (value) =>
                EmailValidator.validate(value ?? "") ? null : validationMsg,
            decoration:  InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black, width: 2.0)),
                border:  const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: AppColors.black)),
                hintText: hintTextVal,
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.lightAsh)),
          ),
        ),
         const SizedBox(
          height: 20,
        ),
        description != null ? Column(
          children: [
            Text(
              description!,
              style: const TextStyle(color: AppColors.ash),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ): const SizedBox()
      ],
    );
  }
}
