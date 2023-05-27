import '../models/customer.dart';

extension CustomerMessages on Customer {
  String get welcome => "Hello, $username!\nYour balance is $balance";

  String get deposit => "Your balance is $balance";
}
