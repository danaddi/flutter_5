import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../routes.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const images = [
    'assets/images/mvc.png',
    'assets/images/mvp.png',
    'assets/images/mvvm.png',
    'assets/images/clean.png',
    'assets/images/layered.png',
  ];

  static const names = [
    'MVC',
    'MVP',
    'MVVM',
    'Clean Architecture',
    'Layered Architecture',
  ];

  static const descriptions = [
    'Разделяет приложение на модель, представление и контроллер.',
    'Использует модель, представление и Presenter.',
    'Связывает представление и данные через ViewModel.',
    'Разделяет бизнес-логику и внешние компоненты.',
    'Организует приложение по отдельным слоям.',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 600;

    final isDesktop = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS;

    final verticalSpacing = isDesktop ? 25.0 : 12.0;

    Widget buildCard(int index) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.account_tree),
          title: Text(names[index]),
          subtitle: Text(descriptions[index]),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  title: names[index],
                  description: descriptions[index],
                  image: images[index],
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'АРХИТЕКТУРНЫЕ ПАТТЕРНЫ',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Архитектурные паттерны',
                  style: TextStyle(fontSize: 21),
                ),
                SizedBox(height: 10),
                Text(
                  'Типовые способы организации структуры '
                      'программного приложения.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      images[index],
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: verticalSpacing),

          Expanded(
            child: isWide
                ? GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: names.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 115,
              ),
              itemBuilder: (context, index) {
                return buildCard(index);
              },
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: verticalSpacing,
                  ),
                  child: buildCard(index),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Дидора Дана Ярославовна\nИКБО-60-23',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(
              context,
              Routes.profile,
            );
          }
        },
      ),
    );
  }
}