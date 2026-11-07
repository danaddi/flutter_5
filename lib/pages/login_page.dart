import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      UserData.email = emailController.text;
      UserData.password = passwordController.text;

      Navigator.pushReplacementNamed(
        context,
        Routes.home,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Добро пожаловать!\n'
                        'Войдите в свой аккаунт\n'
                        'Или создайте новый',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.1,
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                CustomTextFormField(
                  inputType: InputFieldType.email,
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),

                const SizedBox(height: 15),

                CustomTextFormField(
                  inputType: InputFieldType.password,
                  hintText: 'Пароль',
                  icon: Icons.security,
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: login,
                ),

                const SizedBox(height: 5),

                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: 170,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Войти',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Нет аккаунта? '),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.register,
                        );
                      },
                      child: const Text(
                        'Зарегистрируйтесь',
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