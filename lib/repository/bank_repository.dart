import '../util/results.dart';

abstract class BankRepository {
  CommandResults login(String username);
  CommandResults  logout();
}
