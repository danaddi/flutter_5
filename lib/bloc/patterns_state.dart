part of 'patterns_bloc.dart';

@immutable
sealed class PatternsState {
  const PatternsState();
}

final class PatternsInitial extends PatternsState {
  const PatternsInitial();
}

final class PatternsLoading extends PatternsState {
  const PatternsLoading();
}

final class PatternsLoaded extends PatternsState {
  final List<Pattern> patterns;

  const PatternsLoaded(this.patterns);
}

final class PatternsError extends PatternsState {
  final String message;

  const PatternsError(this.message);
}