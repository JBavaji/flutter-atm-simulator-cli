# Flutter ATM Simulator CLI
A flutter Banking process ATM interaction Simulator with Banking system as custmer using Command Line Interface.

#### Usage

```sh
# Create a new Flutter app named my_app
very_good create flutter_app my_app

# help
~ dart run bin/main.dart help 
<img width="493" alt="Screenshot 2023-05-29 at 3 06 35 AM" src="https://github.com/JBavaji/flutter-atm-simulator-cli/assets/46149277/3cb15cda-0735-4611-8c17-3813faa3c345">
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

* Packages used to work with CLI 
 
https://pub.dev/packages/args

https://pub.dev/packages/cli_completion

* Plugin used to auto generate model class

https://plugins.jetbrains.com/plugin/12562-jsontodart-json-to-dart-
 
* Reference packages/github repos used

https://pub.dev/packages/very_good_cli

https://github.com/VeryGoodOpenSource/very_good_cli

https://github.com/imaltsev/atm-cli-simulator


