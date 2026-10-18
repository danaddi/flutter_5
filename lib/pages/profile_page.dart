import 'package:flutter/material.dart';
import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.name);

    emailController =
        TextEditingController(text: widget.email);

    passwordController =
        TextEditingController(text: widget.password);

    confirmController =
        TextEditingController(text: widget.password);
  }

  void save() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Данные сохранены'),
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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),

                    const Expanded(
                      child: Text(
                        'Профиль',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/clean.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                CustomTextFormField(
                  inputType: InputFieldType.name,
                  hintText: 'ФИО',
                  icon: Icons.person_outline,
                  controller: nameController,
                ),

                const SizedBox(height: 15),

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
                ),

                const SizedBox(height: 15),

                CustomTextFormField(
                  inputType: InputFieldType.confirmPassword,
                  hintText: 'Повторите пароль',
                  icon: Icons.security,
                  controller: confirmController,
                  passwordController: passwordController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: save,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: 170,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}