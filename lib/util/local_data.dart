import 'dart:io';

void saveData(String data) {
  final file = File('data.txt');
  file.writeAsStringSync(data);
}

String loadAppCustomerDataFromFile() {
  final file = File('data.txt');
  if (!file.existsSync()) {
    String empty = "[]";
    file.writeAsStringSync(empty);
  }

  return file.readAsStringSync();
}
