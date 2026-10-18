import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import 'profile_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  void register() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 45),

                const Text(
                  'Регистрация',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 45),

                CustomTextFormField(
                  inputType: InputFieldType.name,
                  hintText: 'ФИО',
                  icon: Icons.person_outline,
                  controller: nameController,
                  focusNode: nameFocus,
                  onSubmitted: () {
                    emailFocus.requestFocus();
                  },
                ),

                const SizedBox(height: 15),

                CustomTextFormField(
                  inputType: InputFieldType.email,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  controller: emailController,
                  focusNode: emailFocus,
                  onSubmitted: () {
                    passwordFocus.requestFocus();
                  },
                ),

                const SizedBox(height: 15),

                CustomTextFormField(
                  inputType: InputFieldType.password,
                  hintText: 'Пароль',
                  icon: Icons.security,
                  controller: passwordController,
                  focusNode: passwordFocus,
                  onSubmitted: () {
                    confirmFocus.requestFocus();
                  },
                ),

                const SizedBox(height: 15),

                CustomTextFormField(
                  inputType: InputFieldType.confirmPassword,
                  hintText: 'Повторите пароль',
                  icon: Icons.security,
                  controller: confirmController,
                  passwordController: passwordController,
                  focusNode: confirmFocus,
                  textInputAction: TextInputAction.done,
                  onSubmitted: register,
                ),

                const SizedBox(height: 35),

                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 150),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Уже есть аккаунт? '),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Войдите',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}