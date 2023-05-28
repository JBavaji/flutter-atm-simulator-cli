import 'package:flutter_atm_simulator_cli/models/transfer_customer_amount.dart';

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

  @override
  CommandResults transfer(double amount, String username) {
    if (data.customer!.balance!.enoughBalance(amount)) {
      data.customer?.balance?.withdraw(amount);
    } else {
      return CommandResults.notEnoughBalance;
    }

    int indexToCustomerFound =
        data.customers.indexWhere((customer) => customer.username == username);
    if (indexToCustomerFound < 0) {
      return CommandResults.customerNotExists;
    }

    Customer toCustomer = data.customers[indexToCustomerFound];

    CustomerTransaction loggedInTransaction = CustomerTransaction(
      id: data.customer?.incrementedId(),
      username: toCustomer.username,
      amount: amount,
      type: TransactionType.sent,
    );

    int sentToCustomerIndex = data.customer?.sent.indexWhere(
          (element) => element.username == toCustomer.username,
        ) ??
        -1;

    if (sentToCustomerIndex > -1) {
      data.customer?.sent[sentToCustomerIndex].amount?.deposit(amount);
    } else {
      CustomerTransferAmount transferAmount = CustomerTransferAmount(
        username: toCustomer.username,
        amount: AccountBalance(amount),
      );
      data.customer?.sent.add(transferAmount);
    }
    data.customer?.transaction.add(loggedInTransaction);

    toCustomer.balance?.deposit(amount);
    CustomerTransaction toCustomerTransaction = CustomerTransaction(
      id: toCustomer.incrementedId(),
      username: data.customer?.username,
      amount: amount,
      type: TransactionType.received,
    );
    int receivedToCustomerIndex = toCustomer.received.indexWhere(
      (element) => element.username == data.customer?.username,
    );

    if (receivedToCustomerIndex > -1) {
      toCustomer.received[receivedToCustomerIndex].amount?.deposit(amount);
    } else {
      CustomerTransferAmount transferAmount = CustomerTransferAmount(
        username: data.customer?.username,
        amount: AccountBalance(amount),
      );
      toCustomer.received.add(transferAmount);
    }
    toCustomer.transaction.add(toCustomerTransaction);

    /// Save local toCustomer transaction changes in
    /// banking data before save the user activity
    data.customers[indexToCustomerFound] = toCustomer;

    saveActivity();
    return CommandResults.transfer;
  }
}
