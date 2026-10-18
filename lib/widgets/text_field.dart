import 'package:flutter/material.dart';

enum InputFieldType {
  name,
  email,
  password,
  confirmPassword,
}

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.passwordController,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.focusNode,
  });

  @override
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState
    extends State<CustomTextFormField> {

  bool hidePassword = true;

  String? validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    if (widget.inputType == InputFieldType.name) {
      final reg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$');

      if (!reg.hasMatch(value.trim())) {
        return 'ФИО содержит только буквы и пробелы';
      }
    }

    if (widget.inputType == InputFieldType.email) {
      final reg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

      if (!reg.hasMatch(value.trim())) {
        return 'Введите корректный Email';
      }
    }

    if (widget.inputType == InputFieldType.password) {
      final reg = RegExp(
        r'^(?=.*[A-Za-zА-Яа-я])(?=.*\d)(?=.*[+_-]).{6,}$',
      );

      if (!reg.hasMatch(value)) {
        return 'Нужны буквы, цифры, + _ - и минимум 6 символов';
      }
    }

    if (widget.inputType == InputFieldType.confirmPassword) {
      if (value != widget.passwordController?.text) {
        return 'Пароли не совпадают';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword =
        widget.inputType == InputFieldType.password ||
            widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      validator: validator,
      obscureText: isPassword && hidePassword,
      textInputAction: widget.textInputAction,

      keyboardType:
      widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,

      onFieldSubmitted: (_) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!();
        } else {
          FocusScope.of(context).nextFocus();
        }
      },

      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: Icon(
          widget.icon,
          color: Colors.black,
        ),

        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            hidePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        )
            : null,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}