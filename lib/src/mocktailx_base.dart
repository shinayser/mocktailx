import 'dart:async';

import 'package:mocktail/mocktail.dart';

extension VoidAnswerOnFuture on When<Future<void>> {
  /// The function will be called and completed normally.
  void thenAnswerWithVoid() => thenAnswer((_) => Future<void>.value());
}

extension VoidAnswerOnFutureOr on When<FutureOr<void>> {
  /// The function will be called and completed normally.
  void thenAnswerWithVoid() => thenAnswer((_) => Future<void>.value());
}

extension GenericAnswer<T> on When<Future<T>> {
  /// The function will be called and completed with [value].
  void thenAnswerWith(T value) => thenAnswer((_) => Future<T>.value(value));
}

extension GenericAnswerOr<T> on When<FutureOr<T>> {
  /// The function will be called and completed with [value].
  void thenAnswerWith(T value) => thenAnswer((_) => Future<T>.value(value));
}

extension StreamedAnswer<T> on When<Stream<T>> {
  /// The function will be called and completed with a Stream that emits [values].
  void thenEmit(List<T> values) =>
      thenAnswer((_) => Stream.fromIterable(values));
}

extension VoidAnswerOnVoid on When<void> {
  /// The function will be called and returned with a null result.
  void thenReturnWithVoid() => thenReturn(null);
}

extension WhenExtension<T> on When<T> {
  void thenAnswerInOrder(List<Answer<T>> answers) {
    final originalCount = answers.length;
    return thenAnswer((invocation) {
      if (answers.isEmpty) {
        throw Exception(
          '$originalCount callbacks provided but invoked ${originalCount + 1} times. No more answers available.',
        );
      }
      return answers.removeAt(0)(invocation);
    });
  }

  void thenReturnInOrder(List<T> answers) {
    final originalCount = answers.length;
    return thenAnswer((invocation) {
      if (answers.isEmpty) {
        throw Exception(
          '$originalCount callbacks provided but invoked ${originalCount + 1} times. No more answers available.',
        );
      }
      return answers.removeAt(0);
    });
  }
}
