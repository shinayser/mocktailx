
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