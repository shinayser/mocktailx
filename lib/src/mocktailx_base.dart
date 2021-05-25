import 'package:mocktail/mocktail.dart';

extension VoidAnswer on When<Future<void>> {
  /// The function will be called and completed normally.
  void thenAnswerWithVoid() => thenAnswer((_) => Future<void>.value());
}

extension GenericAnswer<T> on When<Future<T>> {
  /// The function will be called and completed with [value].
  void thenAnswerWith(T value) => thenAnswer((_) => Future<T>.value(value));
}

extension StreamedAnswer<T> on When<Stream<T>> {
  /// The function will be called and completed with a Stream that emits [values].
  void thenEmit(List<T> values) =>
      thenAnswer((_) => Stream.fromIterable(values));
}
