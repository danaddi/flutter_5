import '../models/pattern.dart';

const List<Pattern> patterns = [
  Pattern(
    title: 'MVC',
    shortDescription: 'Model-View-Controller',
    fullDescription:
    'MVC разделяет приложение на три компонента: '
        'Model отвечает за данные, View — за интерфейс, '
        'Controller — за обработку действий пользователя.',
    image: 'assets/images/mvc.png',
  ),

  Pattern(
    title: 'MVP',
    shortDescription: 'Model-View-Presenter',
    fullDescription:
    'MVP разделяет приложение на Model, View и Presenter. '
        'Presenter обрабатывает действия пользователя '
        'и управляет взаимодействием между Model и View.',
    image: 'assets/images/mvp.png',
  ),

  Pattern(
    title: 'MVVM',
    shortDescription: 'Model-View-ViewModel',
    fullDescription:
    'MVVM разделяет интерфейс и логику представления. '
        'ViewModel хранит данные и состояние, '
        'необходимые для отображения во View.',
    image: 'assets/images/mvvm.png',
  ),

  Pattern(
    title: 'Clean Architecture',
    shortDescription: 'Чистая архитектура',
    fullDescription:
    'Clean Architecture разделяет приложение на слои. '
        'Бизнес-логика не должна зависеть от интерфейса '
        'и конкретных источников данных.',
    image: 'assets/images/clean.png',
  ),

  Pattern(
    title: 'Layered Architecture',
    shortDescription: 'Многослойная архитектура',
    fullDescription:
    'Layered Architecture организует приложение '
        'в виде нескольких слоёв, каждый из которых '
        'выполняет собственную задачу.',
    image: 'assets/images/layered.png',
  ),
];