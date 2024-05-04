// Parent Class, Super Class, Base Class
// Immutable Class
class Person {
  final String name;
  final int age;
  final String address;

  Person({
    required this.name,
    required this.age,
    required this.address,
  }) {
    print('Person Class Constructor');
  }

  void printData() {
    print('Name: $name');
    print('Age: $age');
    print('Address: $address');
  }
}

// Non-Immutable Class
// Child Class, Sub Class, Derived Class
class Student extends Person {
  double gpa;
  List<String> courses;

  Student({
    required super.name,
    required super.age,
    required super.address,
    required this.gpa,
    required this.courses,
  }) {
    print('Student Class Constructor');
  }

  @override
  void printData() {
    super.printData();
    print('GPA: $gpa');
    print('Courses: $courses');
  }
}

class Teacher extends Person {
  double salary;
  Teacher({
    required super.name,
    required super.age,
    required super.address,
    required this.salary,
  }) {
    print('Teacher Class Constructor');
  }
}

abstract class Shape {
  double area(double radius, [double height = 1]);
}

class Circle implements Shape {
  @override
  double area(double radius, [double height = 1]) {
    return 3.14 * radius * radius;
  }
}

class Square implements Shape {
  @override
  double area(double radius, [double height = 1]) {
    return radius * height;
  }
}

// Static class Members
class Calculator {
  static double add(double a, double b) {
    return a + b;
  }

  static double sub(double a, double b) {
    return a - b;
  }

  static double mul(double a, double b) {
    return a * b;
  }

  static double div(double a, double b) {
    return a / b;
  }

  static double mod(double a, double b) {
    return a % b;
  }
}

mixin Fly {
  void fly() {
    print('Flying');
  }
}

mixin Swim {
  void swim() {
    print('Swimming');
  }
}

mixin Bark {
  void bark() {
    print('Barking');
  }
}

mixin Meow {
  bool isNice = true;

  void meow() {
    print('Meowing');
  }

  void eat() {
    print('Animal is eating here');
  }
}

class Animal {
  void eat() {
    print('Animal is eating');
  }
}

class Bird with Fly {}

class Crocodile extends Animal with Swim {}

class Dog extends Animal with Bark {}

class Cat extends Animal with Meow {}

class Bat extends Animal with Fly {}

class Duck extends Bird with Fly, Swim {}

enum Color { red, green, blue }

enum AuthPage { login, register, forgotPassword }

enum AuthStatus { loggedIn, loggedOut }

enum ThemeMode { light, dark }

void main() {
  Color c = Color.green;

  print('${c.name[0].toUpperCase()}${c.name.substring(1)} Color');
  // AuthPage authPage = AuthPage.login;

  // switch (authPage) {
  //   case AuthPage.login:
  //     print('Show Login Page');
  //   case AuthPage.register:
  //     print('Show Register Page');
  //   case AuthPage.forgotPassword:
  //     print('Forgot Password Page');
  // }

  // Cat c = Cat();
  // c.meow();
  // // Like Overriding
  // c.eat();
  // Bat b = Bat();
  // b.fly();
  // print(Calculator.add(5, 10));
  // Person p = Person(name: 'Ahmed', age: 20, address: 'Lahore');
  // Student s = Student(
  //   name: 'Ali',
  //   age: 22,
  //   address: 'Karachi',
  //   gpa: 3.5,
  //   courses: ['Math', 'Physics', 'Chemistry'],
  // );

  // // p.name = 'Mohamed'; // More Secured - Immutable
  // s.gpa = 400;
}
