import 'dart:async';

import 'package:mocktailx/mocktailx.dart';
import 'package:test/test.dart';

class TestRepositoryMock extends Mock implements TestRepository {}

void main() {
  late TestRepositoryMock repo;

  setUp(() {
    repo = TestRepositoryMock();
  });

  test('thenReturnWithVoid', () {
    when(repo.voidFunction).thenReturnWithVoid();
    expect(() => repo.voidFunction(), returnsNormally);
  });

  test('thenAnswerWithVoid', () {
    when(repo.futureVoidFunction).thenAnswerWithVoid();
    expect(repo.futureVoidFunction(), completes);

    when(repo.futureVoidOrFunction).thenAnswerWithVoid();
    expect(repo.futureVoidOrFunction(), completes);
  });

  test('thenAnswerWith', () {
    when(repo.asyncInteger).thenAnswerWith(10);
    expect(repo.asyncInteger(), completion(10));

    when(repo.asyncBool).thenAnswerWith(false);
    expect(repo.asyncBool(), completion(false));

    when(repo.asyncString).thenAnswerWith('Nice job');
    expect(repo.asyncString(), completion('Nice job'));

    when(repo.asyncStringOr).thenAnswerWith('Nice job Or!');
    expect(repo.asyncStringOr(), completion('Nice job Or!'));

    when(() => repo.asyncValueWithNamedAndPositionalArgs(any(),
        y: any(named: 'y'))).thenAnswerWith(666);

    expect(repo.asyncValueWithNamedAndPositionalArgs(1, y: 2), completion(666));

    when(repo.asyncPerson).thenAnswerWith(Person('Daniel'));
    expect(repo.asyncPerson(), completion(Person('Daniel')));
  });

  test('thenEmit', () {
    when(repo.streamValue).thenEmit([0, 1, 2, 3]);
    expect(repo.streamValue(), emitsInOrder([0, 1, 2, 3]));
    verify(repo.streamValue).called(1);
  });

  group('thenReturnInOrder', () {
    test('returns different outputs called consecutively with the same input',
        () {

      when(() => repo.addOne(1)).thenReturnInOrder([6, 7, 99]);

      expect(repo.addOne(1), 6);
      expect(repo.addOne(1), 7);
      expect(repo.addOne(1), 99);
    });

    test('returns different outputs called consecutively with any() input', () {
      when(() => repo.addOne(any())).thenReturnInOrder([6, 7, 99]);

      expect(repo.addOne(1), 6);
      expect(repo.addOne(2), 7);
      expect(repo.addOne(3), 99);
    });

    test('throws if invocations do not match callback count', () {
      when(() => repo.addOne(any())).thenReturnInOrder([6]);

      expect(repo.addOne(1), 6);
      try {
        repo.addOne(2);
      } on Exception catch (e) {
        expect(e.toString(),
            'Exception: 1 callbacks provided but invoked 2 times. No more answers available.');
        return;
      }
      fail('Exception block not executed.');
    });
  });

  group('thenAnswerInOrder', () {
    test('returns different outputs called consecutively with the same input',
        () async {
      when(() => repo.asyncInteger()).thenAnswerInOrder([
        (invocation) async => 6,
        (_) async => 7,
        (_) async => 99,
      ]);

      int result = await repo.asyncInteger();
      expect(result, 6);
      result = await repo.asyncInteger();
      expect(result, 7);
      result = await repo.asyncInteger();
      expect(result, 99);
    });

    test('throws if invocations do not match callback count', () async {
      when(() => repo.asyncInteger()).thenAnswerInOrder([
        (invocation) async => 6,
      ]);

      int result = await repo.asyncInteger();
      expect(result, 6);
      try {
        await repo.asyncInteger();
      } on Exception catch (e) {
        expect(e.toString(),
            'Exception: 1 callbacks provided but invoked 2 times. No more answers available.');
        return;
      }
      fail('Exception block not executed.');
    });
  });
}

class Person {
  final String name;

  Person(this.name);

  @override
  bool operator ==(Object other) {
    if (other is Person) {
      return name == other.name;
    }

    return false;
  }
}

class TestRepository {
  int get intValue => 0;

  Map<String, String> get mapValue => {'foo': 'bar'};

  Future<void> futureVoidFunction() => Future.value();

  FutureOr<void> futureVoidOrFunction() => Future.value();

  Future<int> asyncInteger() => Future.value(1);

  Future<bool> asyncBool() => Future.value(true);

  Future<String> asyncString() => Future.value('Just testing');

  FutureOr<String> asyncStringOr() => Future.value('Just testing');

  Future<Person> asyncPerson() => Future.value(Person('Daniel'));

  Future<int> asyncValueWithPositionalArg(int x) => Future.value(x);

  Future<int> asyncValueWithPositionalArgs(int x, int y) => Future.value(x + y);

  Future<int> asyncValueWithNamedArg({required int x}) => Future.value(x);

  Future<int> asyncValueWithNamedArgs({required int x, required int y}) =>
      Future.value(x + y);

  Future<int> asyncValueWithNamedAndPositionalArgs(int x, {required int y}) =>
      Future.value(x + y);

  Stream<int> streamValue() => Stream.value(0);

  int increment(int x) => x + 1;

  int addOne(int x) => x + 1;

  int? returnsNullable() => null;

  void voidFunction() {}

  void voidWithOptionalPositionalArg([int? x]) {}

  void voidWithOptionalNamedArg({int? x}) {}

  void voidWithDefaultPositionalArg([int x = 0]) {}

  void voidWithDefaultNamedArg({int x = 0}) {}

  void voidWithDefaultNamedArgs({int x = 0, int y = 0}) {}

  void voidWithPositionalAndOptionalNamedArg(int x, {int? y}) {}

  void voidWithPositionalArgs(int x, int y) {}
}
