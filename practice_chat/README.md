# practice_chat

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Changes

### 5.03.2022 15:40

я перевел сервис авторизации на кубит...
Теперь модель отвечает за роутинг на основании сервиса, мол если авторизован пользователь то сразу переходи на домашнюю страничку. А виджет модель тоже следит за состоянием но отслеживает только ошибки и с в случае их появления отображает под соотвествующими полями
