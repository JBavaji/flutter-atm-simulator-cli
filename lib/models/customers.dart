import 'dart:convert';

import 'customer.dart';

List<Customer> customersFromFileString(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customersToString(List<Customer> data) => json.encode(data);
