import '../models/customer_transaction.dart';
import '../util/customer_extenstion.dart';
import '../models/account_balance.dart';
import '../models/customer.dart';
import '../models/customers.dart';
import '../util/local_data.dart';
import '../util/results.dart';
import 'bank_data.dart';
import 'bank_repository.dart';

class BankRepositoryImpl extends BankRepository {
  BankData data = BankData.instance;

  @override
  CommandResults login(String username) {
    CommandResults result = CommandResults.logout;

    if (!data.loggedIn) {
      int indexFound = data.customers
          .indexWhere((customer) => customer.username == username);

      if (indexFound < 0) {
        data.customers.add(
          Customer(
              username: username,
              balance: AccountBalance(0),
              transaction: [],
              loggedIn: true),
        );

        saveActivity();
        result = CommandResults.welcome;
      } else {
        data.customers[indexFound].setLoggedIn = true;
        data.customer = data.customers[indexFound];

        saveActivity();
        result = CommandResults.welcome;
      }
    } else {
      if (data.customer?.username == username) {
        result = CommandResults.welcome;
      } else {
        result = CommandResults.alreadyLoggedIn;
      }
    }

    return result;
  }

  @override
  CommandResults logout() {
    CommandResults result;

    if (data.loggedIn) {
      int indexFound = data.customers.indexWhere(
          (customer) => customer.username == data.customer?.username);
      data.customers[indexFound].setLoggedIn = null;

      saveActivity();
      result = CommandResults.logout;
    } else {
      result = CommandResults.alreadyLogout;
    }

    return result;
  }

/*
  Save customer in app file data system
*/

  @override
  CommandResults saveActivity() {
    int indexFound = data.customers
        .indexWhere((customer) => customer.username == data.customer?.username);
    if (indexFound > -1) {
      data.customers[indexFound] = data.customer!;
    }

    String customersString = customersToString(data.customers);
    saveData(customersString);

    data.appInitialize();

    return CommandResults.save;
  }

  @override
  CommandResults transaction(double amount, TransactionType type) {
    if (type == TransactionType.deposit) {
      data.customer?.balance?.deposit(amount);
    } else {
      if (data.customer!.balance!.enoughBalance(amount)) {
        data.customer?.balance?.withdraw(amount);
      } else {
        return CommandResults.notEnoughBalance;
      }
    }

    CustomerTransaction transaction = CustomerTransaction(
      id: data.customer?.incrementedId(),
      username: data.customer?.username,
      amount: amount,
      type: type,
    );

    data.customer?.transaction.add(transaction);

    saveActivity();
    return CommandResults.transaction;
  }
}
