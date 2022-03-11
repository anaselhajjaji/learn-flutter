# Instructions for Dev Environment

- Devcontainer pre-configured to support: Android, Linux and Web (chrome).
- Uses Windows 11 Linux GUI Support.
- Tested under Windows 11 Build 22000 following the [official Linux GUI support documentation](https://docs.microsoft.com/en-us/windows/wsl/tutorials/gui-apps).
- To start the android emulator just do: `flutter emulators --launch android-emulator`
- The devcontainer creates automatically a flutter test project, after starting the emulator just do: `flutter run`
- To run linux version of the application run: `flutter run -d linux`

# Useful tools

- Web based dart editor than can be used to practice dart language: [DartPad](https://dartpad.dev)
- Flutter widgets [catalog](https://docs.flutter.dev/development/ui/widgets)
- Some free fonts from [Google Fonts](https://fonts.google.com/)

# Documentation Approach

Every sample app contains some `// TODO: comment` to highlight and explain every modification.

- Level 1: [First basic app](./basic_flutter_app)
- Level 2: [Personal expenses app](./personal_expenses_app)
- Level 3: [Meals app](./meals_app)
- Level 4: [Shop app](./shop_app)

# Some flutter notions

## Responsive vs Adaptive

Responsiveness is handling different sizes, examples: Portrait mode vs Landscape Mode, Tablet vs Desktop vs Phone ...\
Adaptive is not an official terme but it means adapt the application to the platform UI guidelines, examples: Microsoft Fluent UI, iOS cupertino, Android Material Design ... 

## Widget Lifecycle

- Stateless Widget: Constructor() -> build()
- Statefil Widget: 
    - Constructor() -> initState() -> build() -> dispose()
    - setState() called! -> didUpdateWidget() -> build -> dispose()

# Some dart language notes

## Function arguments and named arguments

```dart
class Person {
    String name;
    int age;

    // By adding {} arguments are optional and will be named
    // @required to force an argument to be required
    // age = 30, set default value
    Person({@required String name, int age = 30}) {
        this.name = name;
        this.age = age;
    }
}

// We can use a shortcut in the previous class
class Person {
    String name;
    int age;

    Person({@required this.name, this.age = 30});
}

// To create a person
var person = new Person(name: 'Anas', age: 40);
```

## Different constructors

```dart
class Person {
    String name;
    int age;

    Person({@required String name, int age = 30}) {
        this.name = name;
        this.age = age;
    }

    Person.veryOld(this.name) {
        age = 80;
    }
}

// To create a person
var person1 = new Person(name: 'Anas', age: 40);
var person2 = Person.veryOld('Mike');
```

## final vs const

Both can't change and the difference is: 
- const: compiled time constant, locked at the moment when writing the code
- final: It's a runtime constant value, it can be initialized after declaration (in constructor for example), locked once initialized at runtime

## Futures

dart executes synchronous code first then goes back to the futures then() functions. 

Note that, then() and catchError() return a future as well so we can have (chaining): `future.then().then()`

Below an example:

```dart
void main() {
    var aFuture = Future(() {
        return 'Future';
    });
    print('This will be printed first.');
    aFuture
        .then((res) => print(res))
        .catchError((err) {});
    print('This will be first as well, before future');
}
```