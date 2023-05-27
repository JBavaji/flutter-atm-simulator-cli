import '../models/customer.dart';
import '../models/customers.dart';
import '../util/local_data.dart';

class BankData {
  BankData._();

  static final instance = BankData._();

  List<Customer> customers = List.empty();

  Customer? customer;

  bool get loggedIn => customer != null;

  void appInitialize() {
    String fileData = loadAppCustomerDataFromFile();
    customers = customersFromFileString(fileData);
 
    int indexFound =
        customers.indexWhere((customer) => customer.loggedIn == true);
    if (indexFound > 0) {
      customer = customers[indexFound];
    }
  }
}
