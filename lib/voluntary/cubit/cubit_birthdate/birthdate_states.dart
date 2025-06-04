abstract class BirthdateStates {}

class DefaultDateState extends BirthdateStates {}

class PickDateState extends BirthdateStates {
  final DateTime pickedDate;
  final int age;
  PickDateState(this.pickedDate, this.age);
}
