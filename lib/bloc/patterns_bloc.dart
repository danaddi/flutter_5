import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/pattern.dart';
import '../mock/patterns_data.dart';

part 'patterns_event.dart';
part 'patterns_state.dart';

class PatternsBloc extends Bloc<PatternsEvent, PatternsState> {
  PatternsBloc() : super(const PatternsInitial()) {
    on<LoadPatternsEvent>(_onLoadPatterns);
  }

  Future<void> _onLoadPatterns(
      LoadPatternsEvent event,
      Emitter<PatternsState> emit,
      ) async {
    emit(const PatternsLoading());

    try {
      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      emit(const PatternsLoaded(patterns));
    } catch (e) {
      emit(
        const PatternsError('Не удалось загрузить паттерны'),
      );
    }
  }
}