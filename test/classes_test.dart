abstract class Logger {
  Logger._internal(name);
  factory Logger(String name) {
    return _ConcreteLogger(name);
  }
}

class _ConcreteLogger extends Logger {
  _ConcreteLogger(String super.name) : super._internal();
}

base class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}

class ImplementLogger implements Logger {
  Car2 car2 = Car2();
  void moveCarForward() {
    car2.moveForward(43);
  }
}

abstract class Vehicle2 {
  String? d = 't';
  String? get getD => d;
  void moveForward(int meters) {
    // ...
  }
}

// ERROR: Can't be inherited.
class Car2 extends Vehicle2 {
  int passengers = 4;

  @override
  void moveForward(int meters) {
    print(d!);
  }
}
