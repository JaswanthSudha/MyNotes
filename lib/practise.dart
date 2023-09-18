// // import 'dart:math';

// // class Person {
// //   static String firstName = "jashu";
// //   String lastName = "sudha";
// //   void breathe() {
// //     print("i can breathe");
// //   }

// //   void run() {
// //     print("I can run");
// //   }
// // }

// // class Cat {
// //   final String name;
// //   Cat(this.name);
// //   // @override
// //   // bool operator ==(covariant Cat other) => name == other.name;
// //   // @override
// //   // int get hashCode => super.hashCode;
// // }

// // void main() {
// //   // final obj = Cat("fool");
// //   // final obj2 = Cat("fool");
// //   // if (obj.name == obj2.name) {
// //   //   print("same");
// //   // } else {
// //   //   print("not same");
// //   // }
// // }
// class Cat {
//   String name;
//   Cat(this.name);
// }

// extension Run on Cat {
//   void run() {
//     print("This is $name");
//   }
// }

// class Person {
//   final String firstName;
//   final String lastName;
//   Person(this.firstName, this.lastName);
// }

// extension FullName on Person {
//   String get fullName => '$firstName $lastName';
//   // String fullName() {
//   //   return '$firstName $lastName';
//   // }
// }

// void main() {
//   final obj = Cat("jashu");
//   obj.run();
//   final person1 = Person("Jaswanth", "Sudha");
//   print(person1.fullName);
// }
Future<int> heavyFuture(int a) {
  return Future.delayed(const Duration(seconds: 10), () {
    return a * 10;
  });
}

void test() async {
  final result = await heavyFuture(10);
  print(result);
}

void main() async {
  // test();
  // await for (final value in getName()) {
  //   print(value);
  // }
  // print(getOne());
  final names = Pair(1, "Sudha");
  print(names.value1);
}

Iterable<int> getOne() sync* {
  yield 1;
}

Stream<String> getName() {
  return Stream.periodic(const Duration(seconds: 1), (value) {
    return 'foo';
  });
}

class Pair<A, B> {
  final A value1;
  final B value2;
  Pair(this.value1, this.value2);
}
