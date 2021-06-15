abstract class TransactionNavBarEvent {}

class SelectDateEvent extends TransactionNavBarEvent {
  final DateTime selectedDate;

  SelectDateEvent(this.selectedDate);
}
