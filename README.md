# Flutter ATM Simulator CLI
A flutter Banking process ATM interaction Simulator with Banking system as custmer using Command Line Interface.

#### Usage

```sh
# Create a new Flutter app named my_app
very_good create flutter_app my_app

# help
~ dart run bin/main.dart help 
<img width="503" alt="image" src="https://github.com/JBavaji/flutter-atm-simulator-cli/assets/46149277/fc6c9513-1c15-49dc-bebc-a6e0439c85d1">


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


