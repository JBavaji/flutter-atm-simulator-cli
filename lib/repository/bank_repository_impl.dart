import 'dart:io';

import 'package:flutter_atm_simulator_cli/models/transfer_customer_amount.dart';
import 'package:flutter_atm_simulator_cli/util/balance_extension.dart';

import '../models/customer_transaction.dart';
import '../util/customer_operation_extentsion.dart';
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
  CommandResults withdraw(double amount) {
    if (data.customer!.haveEnoughBalance(amount)) {
      data.customer?.balance?.withdraw(amount);
    } else {
      return CommandResults.notEnoughBalance;
    }

    data.customer?.transaction.add(
      CustomerTransaction.usingCustomer(
        data.customer,
        TransactionType.withdraw,
        amount,
      ),
    );

    saveActivity();
    return CommandResults.withdraw;
  }

  @override
  CommandResults deposit(double amount) {
    double depositAmount = transferOwedAmount(amount);
    if (depositAmount <= 0) {
      return CommandResults.deposit;
    }

    data.customer?.balance?.deposit(depositAmount);

    data.customer?.transaction.add(
      CustomerTransaction.usingCustomer(
        data.customer,
        TransactionType.deposit,
        depositAmount,
      ),
    );

    saveActivity();
    return CommandResults.deposit;
  }

  @override
  CommandResults transfer(double amount, String username) {
    if (data.customer!.haveEnoughBalance(amount)) {
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

    int sentToCustomerIndex = data.customer?.sent.indexWhere(
          (element) => element.username == toCustomer.username,
        ) ??
        -1;

    if (sentToCustomerIndex > -1) {
      data.customer?.sent[sentToCustomerIndex].amount?.deposit(amount);
    } else {
      data.customer?.sent.add(
        CustomerOweAmount(
          username: toCustomer.username,
          amount: AccountBalance(amount),
        ),
      );
    }
    data.customer?.transaction.add(CustomerTransaction(
      id: data.customer?.incrementedId(),
      username: toCustomer.username,
      amount: amount,
      type: TransactionType.sent,
    ));

    toCustomer.balance?.deposit(amount);
    int receivedToCustomerIndex =
        toCustomer.findUserFromReceived(data.customer?.username);

    if (receivedToCustomerIndex > -1) {
      toCustomer.received[receivedToCustomerIndex].amount?.deposit(amount);
    } else {
      toCustomer.received.add(
        CustomerOweAmount(
          username: data.customer?.username,
          amount: AccountBalance(amount),
        ),
      );
    }
    toCustomer.transaction.add(
      CustomerTransaction(
        id: toCustomer.incrementedId(),
        username: data.customer?.username,
        amount: amount,
        type: TransactionType.received,
      ),
    );

    /// Save local toCustomer transaction changes in
    /// banking data before save the user activity
    data.customers[indexToCustomerFound] = toCustomer;

    saveActivity();
    return CommandResults.transaction;
  }

  double transferOwedAmount(double amount) {
    if (data.customer!.received.isNotEmpty) {
      CustomerOweAmount? owedAmount;

      int owedAmountIndex = data.customer!.received
          .indexWhere((element) => amount.canWithdraw(element.amount!.balance));

      if (owedAmountIndex != -1) {
        owedAmount = data.customer!.received.elementAt(owedAmountIndex);
        data.customer!.received.removeAt(owedAmountIndex);

        int owedCustomerIndex = data.customers.indexWhere(
            (customer) => customer.username == owedAmount?.username);
        if (owedCustomerIndex != -1) {
          Customer owedCustomer = data.customers.elementAt(owedCustomerIndex);
          owedCustomer.sent.removeWhere(
              (element) => element.username == data.customer?.username);

          owedCustomer.balance?.deposit(owedAmount.amount!.balance);

          owedCustomer.transaction.add(
            CustomerTransaction.usingCustomer(
              owedCustomer,
              TransactionType.sent,
              amount,
            ),
          );

          amount = amount - owedAmount.amount!.balance;

          /// Save local toCustomer transaction changes in
          /// banking data before save the user activity
          data.customers[owedCustomerIndex] = owedCustomer;

          stdout.writeln(
              'Transferred ${AccountBalance(owedAmount.amount!.balance).toString()} to ${owedCustomer.username}');
        }
      }
    }
    return amount;
  }
}
