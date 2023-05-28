import '../models/customer.dart';

extension CustomerMessages on Customer {
  String get welcome => "Hello, $username!\n$deposit";

  String get deposit => "Your balance is ${balance.toString()}";

  String get goodBye => "Goodbye, $username!";

  String get continueTransaction =>
      'You can continue transaction with existing $username';

  int incrementedId() {
    int count = transaction.length;
    if (count == 0) {
      return 1;
    } else {
      int id = transaction[count - 1].id as int;
      return ++id;
    }
  }
}

extension NoCustomer on String {
  String get noCustomerLogged => "No logged customer found";
}
