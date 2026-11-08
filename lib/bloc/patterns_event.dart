part of 'patterns_bloc.dart';

@immutable
sealed class PatternsEvent {
  const PatternsEvent();
}

final class LoadPatternsEvent extends PatternsEvent {
  const LoadPatternsEvent();
}