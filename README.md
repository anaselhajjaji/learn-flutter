# Instructions for Dev Environment

- Devcontainer pre-configured to support: Android, Linux and Web (chrome).\
- Uses Windows 11 Linux GUI Support.\
- Tested under Windows 11 Build 22000 following the [official Linux GUI support documentation](https://docs.microsoft.com/en-us/windows/wsl/tutorials/gui-apps).\
- To start the android emulator just do: `flutter emulators --launch android-emulator`
- The devcontainer creates automatically a flutter test project, after starting the emulator just do: `flutter run`
- To run linux version of the application run: `flutter run -d linux`

# Documentation Approach

Every sample app contains some `// TODO: comment` to highlight and explain every modification.

- [First basic app](./basic_flutter_app)
- ...

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