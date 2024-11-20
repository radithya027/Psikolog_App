import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for input formatters
import 'package:psikolog_app/infrastructure/theme/theme.dart';

class Customfield extends StatefulWidget {
  const Customfield({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.isNumeric = false,
    this.controller,
    this.onChanged,
  });

  final String labelText;
  final bool isPassword;
  final bool isNumeric;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<Customfield> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_isPasswordVisible,
      maxLines: widget.isPassword ? 1 : null,
      style: AppTextStyle.tsBodyRegular(AppColor.black),
      keyboardType:
          widget.isNumeric ? TextInputType.number : TextInputType.text,
      inputFormatters: widget.isNumeric
          ? [FilteringTextInputFormatter.digitsOnly]
          : null, // Apply only for numeric input
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.grey),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.blue500),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.blue500),
        ),
        fillColor: AppColor.white,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColor.black,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        labelText: widget.labelText,
        labelStyle: AppTextStyle.tsSmallRegular(AppColor.black),
      ),
      onChanged: widget.onChanged,
    );
  }
}
