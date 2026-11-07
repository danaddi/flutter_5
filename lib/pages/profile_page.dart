import 'package:flutter/material.dart';
import '../routes.dart';
import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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

    nameController = TextEditingController(
      text: UserData.name,
    );

    emailController = TextEditingController(
      text: UserData.email,
    );

    passwordController = TextEditingController(
      text: UserData.password,
    );

    confirmController = TextEditingController(
      text: UserData.password,
    );
  }

  void save() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      UserData.name = nameController.text;
      UserData.email = emailController.text;
      UserData.password = passwordController.text;

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
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
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
                    child: const Text('Сохранить'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(
              context,
              Routes.home,
            );
          }
        },
      ),
    );
  }
}