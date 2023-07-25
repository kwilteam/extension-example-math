# Extension Deployment Template

This repo contains an example usage of the [template for running Kwil extensions using Docker Compose](<https://github.com/kwilteam/extension-deployment-template>).
It uses a sample [math extension](<https://https://github.com/kwilteam/kwil-extensions/tree/main/examples/math>).

## Quickstart

To download the images and run them as containers, run:

```bash
make download-and-run
```

## Usage

To use this repo, you will need to install and configure the [Kwil CLI](<https://docs.kwil.com/docs/cli/installation>).  Within the CLI, you will need to configure:

1. A private key (Ethereum compatible).
2. A Kwil provider (your locally running node, by default this will be `localhost:50051`)

### Makefile

This repo contains a makefile that with common commands that may be run in this repo.  To see all commands, run:

```bash
make help
```

### Scripts

This repo also contains scripts which showcase how to interact with the example Kuneiform schema using the Kwil CLI.  The examples show how to use
basic math functions from the `math` extension.  The script file contains the following functions:

- `deploy`: deploys the [example schema](./schemas/use_math.kf).
- `add`: prompts the user for values to add (in the deployed database)
- `sub`: prompts the user for values to subtract (in the deployed database)
- `mul`: prompts the user for values to multiply (in the deployed database)
- `div`: prompts the user for values to divide (in the deployed database)

To run a script, simply run:

```bash
./script.sh deploy
```

**NOTE:** depending on your local machine settings, you may get a permissions error when using the scripts.  To fix this on Unix systems, simply run:

```bash
chmod +X ./script.sh
```

## Math Extension

The math extension is an extension that can perform the basic math operations of addition, subtraction, multiplication, and division.  It likely has no real applicable use case, other than to show how to build and use extensions.

### Initialization

The math extension can be initialized to either round non-integer reulsts `up` or `down`.  In Kuneiform, this looks like the following:

```typescript
use math {
    round: "up"
} as math_up;

use math {
    round: "down"
} as math_down;
```

### Invoking a Method

The extension's methods can be called from within an action:

```typescript
action call_add($num1) public {
    $sum = math_up.add($num1, 2); // adds 2 to the passed value, and returns it as $sum
    // ... the rest of the action ...
} 
```
