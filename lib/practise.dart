// // // // // import 'dart:math';

// // // // // class Person {
// // // // //   static String firstName = "jashu";
// // // // //   String lastName = "sudha";
// // // // //   void breathe() {
// // // // //     print("i can breathe");
// // // // //   }

// // // // //   void run() {
// // // // //     print("I can run");
// // // // //   }
// // // // // }

// // // // // class Cat {
// // // // //   final String name;
// // // // //   Cat(this.name);
// // // // //   // @override
// // // // //   // bool operator ==(covariant Cat other) => name == other.name;
// // // // //   // @override
// // // // //   // int get hashCode => super.hashCode;
// // // // // }

// // // // // void main() {
// // // // //   // final obj = Cat("fool");
// // // // //   // final obj2 = Cat("fool");
// // // // //   // if (obj.name == obj2.name) {
// // // // //   //   print("same");
// // // // //   // } else {
// // // // //   //   print("not same");
// // // // //   // }
// // // // // }
// // // // class Cat {
// // // //   String name;
// // // //   Cat(this.name);
// // // // }

// // // // extension Run on Cat {
// // // //   void run() {
// // // //     print("This is $name");
// // // //   }
// // // // }

// // // // class Person {
// // // //   final String firstName;
// // // //   final String lastName;
// // // //   Person(this.firstName, this.lastName);
// // // // }

// // // // extension FullName on Person {
// // // //   String get fullName => '$firstName $lastName';
// // // //   // String fullName() {
// // // //   //   return '$firstName $lastName';
// // // //   // }
// // // // }

// // // // void main() {
// // // //   final obj = Cat("jashu");
// // // //   obj.run();
// // // //   final person1 = Person("Jaswanth", "Sudha");
// // // //   print(person1.fullName);
// // // // }
// // // Future<int> heavyFuture(int a) {
// // //   return Future.delayed(const Duration(seconds: 10), () {
// // //     return a * 10;
// // //   });
// // // }

// // // void test() async {
// // //   final result = await heavyFuture(10);
// // //   print(result);
// // // }

// // // void main() async {
// // //   // test();
// // //   // await for (final value in getName()) {
// // //   //   print(value);
// // //   // }
// // //   // print(getOne());
// // //   // final names = Pair(1, "Sudha");

// // //   // print(names.value1);s
// // //   final names = Generic("jashu");
// // // }

// // // Iterable<int> getOne() sync* {
// // //   yield 1;
// // // }

// // // Stream<String> getName() {
// // //   return Stream.periodic(const Duration(seconds: 1), (value) {
// // //     return 'foo';
// // //   });
// // // }

// // // class Pair<A, B> {
// // //   final A value1;
// // //   final B value2;
// // //   Pair(this.value1, this.value2);
// // // }

// // // class Generic<T> {
// // //   final T value;
// // //   Generic(this.value);
// // // }
// // import 'dart:collection';

// // class DatabasUser {
// //   final int id;
// //   final String email;
// //   DatabasUser({
// //     required this.id,
// //     required this.email,
// //   });
// //   DatabasUser.fromRow(Map<String, Object?> map)
// //       : id = map[idColumn] as int,
// //         email = map[emailColumn] as String;
// // }

// // const idColumn = "id";
// // const emailColumn = "email";

// // class Point {
// //   final double x;
// //   final double y;
// //   Point(this.x, this.y);
// //   // named constructor
// //   Point.orgin(double a)
// //       : x = a,
// //         y = a;
// // }

// // const double xOrgin = 0;
// // const double yOrgin = 0;
// // void main() {
// //   final Point axis = Point.orgin(1.3);
// //   final Point axis2 = Point(2.3, 4.5);
// //   print(axis.x);
// //   print(axis.y);
// //   print(axis2.x);
// // }

// // // void main() {
// // //   final Map<String, Object> map = HashMap();
// // //   map["jashu"] = "email";
// // //   print(map);
// // // }
// class DatabasUser {
//   final int id;
//   final String email;
//   DatabasUser({
//     required this.id,
//     required this.email,
//   });
//   DatabasUser.fromRow(Map<String, Object?> map)
//       : id = map['id'] as int,
//         email = map['email'] as String;
// }

// const idColum = "1";
// const emailColum = "email";
// void main() {
//   const id = "1";
// }

