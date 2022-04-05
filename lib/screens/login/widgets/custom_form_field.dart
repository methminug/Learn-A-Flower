import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController _emailController;
  final FocusNode _emailFocusNode;
  final TextInputAction _inputAction;
  final bool isCapitalized;
  final bool isLabelEnabled;
  final Function(String) _validator;

  const CustomFormField({
    Key? key,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputAction inputAction,
    required Function(String value) validator,
    this.isCapitalized = false,
    this.isLabelEnabled = true,
  })  : _emailController = controller,
        _emailFocusNode = focusNode,
        _inputAction = inputAction,
        _validator = validator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.text,
      obscureText: false,
      textCapitalization: isCapitalized ? TextCapitalization.words : TextCapitalization.none,
      textInputAction: _inputAction,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      validator: (value) => _validator(value!),
      decoration: InputDecoration(
        labelText: isLabelEnabled ? 'User Name' : null,
        labelStyle: const TextStyle(color: Colors.black),
        hintText: 'Enter your username (admin / user)',
        hintStyle: TextStyle(
          color: AppColors.blueGreen.withOpacity(0.5),
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: AppColors.blueGreen,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: AppColors.blueGreen.withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
