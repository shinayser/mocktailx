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
  });

  test('thenAnswerWith', () {
    when(repo.asyncInteger).thenAnswerWith(10);
    expect(repo.asyncInteger(), completion(10));

    when(repo.asyncBool).thenAnswerWith(false);
    expect(repo.asyncBool(), completion(false));

    when(repo.asyncString).thenAnswerWith('Nice job');
    expect(repo.asyncString(), completion('Nice job'));

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

  Future<int> asyncInteger() => Future.value(1);

  Future<bool> asyncBool() => Future.value(true);

  Future<String> asyncString() => Future.value('Just testing');

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
