# Flutter ATM Simulator CLI
A flutter Banking process ATM interaction Simulator with Banking system as custmer using Command Line Interface.

#### Usage

```sh
# login [Login existing or Create new user as customer]
% dart run bin/main.dart login --username JBAVAJI

Hello, JBAVAJI! 
Your balance is $0.0

# deposit
% dart run bin/main.dart deposit --amount 100
Your balance is $100.0

# logout
% dart run bin/main.dart logout
Goodbye, JBAVAJI!  

# login
% dart run bin/main.dart login 
Username required:
JBAVAJI
Hello, JBAVAJI! 
Your balance is $100.0

#withdraw 
% dart run bin/main.dart withdraw --amount 30
Your balance is $70.0

#statement
% dart run bin/main.dart statement
Hello, JBAVAJI! 
Your balance is $50.0

Your transactions:
You withdraw amount $20.0.
You deposit amount $70.0.


# logout
% dart run bin/main.dart logout
Goodbye, JBAVAJI! 

#login [Another customer already loggedIn. Not logout yet...]
% dart run bin/main.dart login --username jayeshgiri
JBAVAJI already loggedIn.
Need to logout before continue. Press Enter or Key press Y/y...
Y

Goodbye, JBAVAJI!

#login [run command with --username value. Will ask to enter value for login.]
% dart run bin/main.dart login
Username required:
jayeshgiri
Hello, jayeshgiri! 
Your balance is $0.0

# deposit
% dart run bin/main.dart deposit
Amount:
200
Your balance is $200.0

# transfer 
% dart run bin/main.dart transfer --amount 40 --username JBAVAJI
You transferred $40 to JBAVAJI.
Your balance is $160.0

# logout
% dart run bin/main.dart logout 
Goodbye, jayeshgiri!

# login
% dart run bin/main.dart login
Username required:
JBAVAJI
Hello, JBAVAJI! 
Your balance is $90.0

Owed $40.0 to jayeshgiri

# transfer 
% dart run bin/main.dart transfer
Amount:
23
Username:
JBAVAJI
You can not transfer to your own account

# deposit
% dart run bin/main.dart deposit
Amount:
50
Transferred $23.0 to JBAVAJI
Your balance is $250.0

# statement
% dart run bin/main.dart statement
Hello, jayeshgiri! 
Your balance is $250.0

Your transactions:
You deposit amount $27.0.
You received amount $23.0 from JBAVAJI.
You sent amount $85.0 to jayeshgiri.
You sent amount $40.0 to JBAVAJI.
You deposit amount $200.0.

# logout
% dart run bin/main.dart logout   
Goodbye, jayeshgiri!

# help
% dart run bin/main.dart help 

+----------------------------------------------------------+
|           Welcome to the ATM Simulate!                   |
+----------------------------------------------------------+

login [--username @@@]
Logs in or create as this customer

deposit [--amount $$$]
Deposit amount to the logged in customer

withdraw [--amount $$$]
Withdraw amount from the logged in customer

statement [--type mini/all]
Print of the current customer transaction.
[mini] - Most recent 1o transactions of current customer.
[all] - All transactions of current customer.

transfer [--amount $$$ --username @@@] 
Transfer amount to user from the current customer transaction.

logout
Logs out of the current customer

help
Get help for supported command to use ATM simulator

+----------------------------------------------------------+
|    Developer: Jayeshgiri Bavaji (JBavaji)                |
|    Website: https://jbavaji.github.io                    |
|    Email: jbavaji@gmail.com                              |
|    Contact: +91 96018 33544                              |
+----------------------------------------------------------+

```

## Notes

### Supports

Application is supported in mac / windows / linux as os system.

### Run

To run the program use: 
Open terminal with project root folder

```bash
> dart run bin/main.dart [command --args value]
```

### Help

To see all available commands use:

```bash
> dart run bin/main.dart help 
```

### Some development points

* Execution entry point 
```bash
> root-project /bin/main.dart
```

* File storage system used to save customer information and related transactions

A data file can be found here `./data.txt`.
Sample customer information can be found here `./sample_data.json`. 

* Business logic and state placed in both 'repository' package and 'models' package.
```bash
> lib/models/
> lib/repository
```

* Command execution runner and all commands placed in package.
```bash
> lib/commands/commands.dart

export 'help.dart';
export 'login.dart';
export 'deposit.dart';
export 'withdraw.dart';
export 'statement.dart';
export 'transfer.dart';
export 'logout.dart';
export 'unknown.dart';
```

* New user create "Customer" data model
```bash
{
"username": "JBAVAJI",
"balance": 0.0,
"loggedIn": true,
"transaction": [
],
"sent": [],
"received": []
}
```

* Customer deposit / withdraw amount "CustomerTransaction" data model
```bash
[
  {
    "username": "JBAVAJI",
    "balance": 50.0,
    "loggedIn": true,
    "transaction": [
      {
        "id": 1,
        "type": "deposit",
        "amount": 70.0,
        "username": "JBAVAJI"
      },
      {
        "id": 2,
        "type": "withdraw",
        "amount": 20.0,
        "username": "JBAVAJI"
      }
    ],
    "sent": [],
    "received": []
  }
]
```

* Customer transfer amount to another customer as owe amount "CustomerOweAmount" data model
```bash
 [
  {
    "username": "JBAVAJI",
    "balance": 90.0,
    "loggedIn": null,
    "transaction": [
      {
        "id": 1,
        "type": "deposit",
        "amount": 70.0,
        "username": "JBAVAJI"
      },
      {
        "id": 2,
        "type": "withdraw",
        "amount": 20.0,
        "username": "JBAVAJI"
      },
      {
        "id": 3,
        "type": "received",
        "amount": 40.0,
        "username": "jayeshgiri"
      }
    ],
    "sent": [],
    "received": [
      {
        "amount": 40.0,
        "username": "jayeshgiri"
      }
    ]
  },
  {
    "username": "jayeshgiri",
    "balance": 160.0,
    "loggedIn": true,
    "transaction": [
      {
        "id": 1,
        "type": "deposit",
        "amount": 200.0,
        "username": "jayeshgiri"
      },
      {
        "id": 2,
        "type": "sent",
        "amount": 40.0,
        "username": "JBAVAJI"
      }
    ],
    "sent": [
      {
        "amount": 40.0,
        "username": "JBAVAJI"
      }
    ],
    "received": []
  }
]
```

* Packages used to work with CLI 
 
https://pub.dev/packages/args

https://pub.dev/packages/cli_completion

* Plugin used to auto generate model class

https://plugins.jetbrains.com/plugin/12562-jsontodart-json-to-dart-
 
* Reference packages/github repos used

https://pub.dev/packages/very_good_cli

https://github.com/VeryGoodOpenSource/very_good_cli

https://github.com/imaltsev/atm-cli-simulator


