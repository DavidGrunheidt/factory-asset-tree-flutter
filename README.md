![Coverage](./coverage_badge.svg)

# Asset Tree Flutter App
## Project setup

- Install [Flutter Version Management][fvm]
- Make sure you have the latest fvm version: `fvm --version`
- Run `make clean` to get all dependencies for the project
- It will ask if you want to download the project's Flutter version. Type `y` and enter:
- ![fvmInstall](https://i.imgur.com/KIFaCc5.png)
- Run `make gen-code` to generate all missing code

That's it, you are ready to go!

## App videos

- Jaguar unit (small number of items): https://i.imgur.com/nni4Q1i.mp4
- Tobias unit (medium number of items): https://i.imgur.com/GPnqztx.mp4
- Apex unit (high number of items): https://i.imgur.com/VmU22JN.mp4

## To improve

- When filtering a huge list there's a small delay on one of the frames rendering. We need to improve that to make the tap more smoother and also the transition to the filtering state smoother.

### Tests
- Run `make ci-tests` to run all unit tests

## Overview

### Architecture

- This project follows [Model–view–viewmodel (MVVM)][mvvm] for its architecture.
    - `models` are stored in the /models directory
    - each screen on the app is a `view`
    - `views` should use `viewmodels` exclusively to manage data/service calls (instead of using models/services directly)

## Tests

- Tests should mirror the same folder structure of the class that they are testing.

## boot.dart

- Initialization and startup logic should be done here.
- Initalize locators, SDKs, etc.
- Called by all Flavors.

## main_<flavor>.dart

- Entry point for each Flavor of the app
- There is one Flavor per environment (stg, prod)
- Use `flavors.dart` to define Flavor specific values that are not secret (baseURL, etc).

[fvm]: https://fvm.app/documentation/getting-started/installation
[codemagic]: https://codemagic.io/apps
[mvvm]: https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel
