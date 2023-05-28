
extension ErrorMessage on String {
  String get noCustomerLogged => "No logged customer.";

  String get noCustomerFound => "No customer found with username";

  String get emptyCustomerUsername => "Username can not be empty for transfer.";

  String get invalidNumber => "Invalid amount entered.";

  String get negativeNumber => "Amount can not be negative number.";
}