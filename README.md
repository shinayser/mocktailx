
## mocktailx
A set of utility functions for [mocktail](https://pub.dev/packages/mocktail) apis.

## Usage

First import mocktailx to your pubspec:

```yaml  
mocktailx: ^0.0.4
```  
Note that this library is a container for **mocktail** `0.3.0`, so you **don't** need to import **mocktail**.  
And don't forget to fix your imports:

```dart 
import 'package:mocktailx/mocktailx.dart';  
```  

## Features

#### thenAnswerWithVoid
```dart  
// Instead of doing:  
when(repo.futureVoidFunction).thenAnswer((invocation) async {});  
// You can just:  
when(repo.futureVoidFunction).thenAnswerWithVoid();   
```  

#### thenAnswerWith(T)
```dart  
// Instead of doing:  
when(repo.futureIntFunction).thenAnswer((invocation) async => 10);  
// You can just:  
when(repo.futureIntFunction).thenAnswerWith(10);  
```  

#### thenAnswerInOrder(List<Answer<T>>)
```dart  
// Instead of doing:  
final List<Future<int> Function(Invocation)> answers = [
(_) async => 6,
(_) async => 7,
(_) async => 99,
]; 
when(() => repo.asyncInteger()).thenAnswer((invocation) => answers.removeAt(0)(invocation));
// You can just:  
when(() => repo.asyncInteger()).thenAnswerInOrder([
    (invocation) async => 6,
    (_) async => 7,
    (_) async => 99,
]);
```  


#### thenEmit(List)

```dart  
// Instead of doing:  
when(repo.streamValue).thenAnswer((invocation) => Stream.fromIterable([1,2,3,4,5]));  
// You can just:  
when(repo.streamValue).thenEmit([1,2,3,4,5]);  
```

#### thenReturnWithVoid
```dart  
// Instead of doing:  
when(repo.voidFunction).thenReturn(null);  
// You can just:  
when(repo.voidFunction).thenReturnWithVoid();   
```  

#### thenReturnInOrder(List<T>)
```dart  
// Instead of doing:  
when(() => repo.addOne(1)).thenReturn(6);
when(() => repo.addOne(2)).thenReturn(7);
when(() => repo.addOne(3)).thenReturn(99);

// You can just:  
when(() => repo.addOne(any())).thenReturnInOrder([6, 7, 99]);
```
```dart  
// Instead of doing:  
final answers = [6, 7, 99];
when(() => repo.addOne(1)).thenAnswer((invocation) => answers.removeAt(0));

// You can just:  
when(() => repo.addOne(1)).thenReturnInOrder([6, 7, 99]);
```