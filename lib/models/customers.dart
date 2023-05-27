import 'dart:convert';

import 'customer.dart';

List<Customer> customersFromFileString(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

// List<Map<String, dynamic>> _customersToData(List<Customer> data) =>
//     data.map((e) => e.toJson()).toList();

String customersToString(List<Customer> data) {
  return json.encode(data);
}
