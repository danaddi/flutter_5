import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/patterns_bloc.dart';
import '../routes.dart';
import 'detail_page.dart';

import '../models/pattern.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 600;

    final isDesktop = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS;

    final verticalSpacing = isDesktop ? 25.0 : 12.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'АРХИТЕКТУРНЫЕ ПАТТЕРНЫ',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),

      body: BlocBuilder<PatternsBloc, PatternsState>(
        builder: (context, state) {
          // Начальное состояние
          if (state is PatternsInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<PatternsBloc>().add(
                    const LoadPatternsEvent(),
                  );
                },
                child: const Text('Показать паттерны'),
              ),
            );
          }

          // Загрузка
          if (state is PatternsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Ошибка
          if (state is PatternsError) {
            return Center(
              child: Text(state.message),
            );
          }

          // Данные загружены
          if (state is PatternsLoaded) {
            final patterns = state.patterns;

            return Column(
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

                // Горизонтальный список изображений
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: patterns.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            patterns[index].image,
                            width: 170,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: verticalSpacing),

                // Карточки
                Expanded(
                  child: isWide
                      ? GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: patterns.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 115,
                    ),
                    itemBuilder: (context, index) {
                      return _buildCard(
                        context,
                        patterns[index],
                      );
                    },
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: patterns.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: verticalSpacing,
                        ),
                        child: _buildCard(
                          context,
                          patterns[index],
                        ),
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
            );
          }

          return const SizedBox();
        },
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
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

  Widget _buildCard(BuildContext context, Pattern pattern) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.account_tree),

        title: Text(pattern.title),

        subtitle: Text(pattern.shortDescription),

        trailing: const Icon(Icons.arrow_forward_ios),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                title: pattern.title,
                description: pattern.fullDescription,
                image: pattern.image,
              ),
            ),
          );
        },
      ),
    );
  }
}