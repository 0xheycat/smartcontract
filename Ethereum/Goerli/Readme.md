* Have API RPC from Alchemi or Blastapi https://houston.blastapi.io/dashboard/project for alchemi https://www.alchemy.com/
* Private keys from your Metamask
* Enough ETH Balance , faucet ETH Goerli https://goerlifaucet.com/

## Install Requirement
```bash
sudo npm install -g yarn
```
```bash
sudo apt update
sudo apt install nodejs
```

## Create your Project
Create Your Directory project
```bash
mkdir hello-world
cd hello-world
```

```bash
npm init
```

It doesn’t really matter how you answer the installation questions, here simple reference:
```bash
package name: (hello-world)
version: (1.0.0)
description: Meowbored smart contract
entry point: (index.js)
test command:
git repository:
keywords:
author:
license: (ISC)

About to write to /Users/.../.../.../hello-world/package.json:

{
   "name": "hello-world",
   "version": "1.0.0",
   "description": "hello world smart contract",
   "main": "index.js",
   "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1"
   },
   "author": "",
   "license": "ISC"
}
```
## Download Hardhat
Hardhat is a development environment to compile, deploy, test, and debug your Ethereum software. It helps developers when building smart contracts and dApps locally before deploying to the live chain.
Inside your 'hello-world' directory
```bash
npm install --save-dev hardhat
```
 Create Hardhat project
```bash
npx hardhat
```
You should then see a welcome message and option to select what you want to do. Select `create an empty hardhat.config.js`
```bash
888    888                      888 888               888
888    888                      888 888               888
888    888                      888 888               888
8888888888  8888b.  888d888 .d88888 88888b.   8888b.  888888
888    888     "88b 888P"  d88" 888 888 "88b     "88b 888
888    888 .d888888 888    888  888 888  888 .d888888 888
888    888 888  888 888    Y88b 888 888  888 888  888 Y88b.
888    888 "Y888888 888     "Y88888 888  888 "Y888888  "Y888

👷 Welcome to Hardhat v2.0.11 👷‍

What do you want to do? …
Create a sample project
❯ Create an empty hardhat.config.js
Quit
```
This will generate a `hardhat.config.js` file

## Create contract and scripts folder
```bash
mkdir contracts
mkdir scripts
```

* `contracts` is where we’ll keep our hello world smart contract code file
* `scripts` is where we’ll keep scripts to deploy and interact with our contract

## Write Smart contract
create new `HelloWorld.sol` file 
1. Navigate to the `contracts` folder and create a new file called `HelloWorld.sol`
2. Below is a sample Hello World smart contract from the Ethereum Foundation, Copy and paste in the contents below into your `HelloWorld.sol` file, and be sure to read the comments to understand what this contract does:
```bash
sudo nano ~/hello-world/scripts/HelloWorld.sol
```
copy text below inside `HelloWorld.sol` file
```bash
// Specifies the version of Solidity, using semantic versioning.
// Learn more: https://solidity.readthedocs.io/en/v0.5.10/layout-of-source-files.html#pragma
pragma solidity >=0.7.3;

// Defines a contract named `HelloWorld`.
// A contract is a collection of functions and data (its state). Once deployed, a contract resides at a specific address on the Ethereum blockchain. Learn more: https://solidity.readthedocs.io/en/v0.5.10/structure-of-a-contract.html
contract HelloWorld {

   //Emitted when update function is called
   //Smart contract events are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.
   event UpdatedMessages(string oldStr, string newStr);

   // Declares a state variable `message` of type `string`.
   // State variables are variables whose values are permanently stored in contract storage. The keyword `public` makes variables accessible from outside a contract and creates a function that other contracts or clients can call to access the value.
   string public message;

   // Similar to many class-based object-oriented languages, a constructor is a special function that is only executed upon contract creation.
   // Constructors are used to initialize the contract's data. Learn more:https://solidity.readthedocs.io/en/v0.5.10/contracts.html#constructors
   constructor(string memory initMessage) {

      // Accepts a string argument `initMessage` and sets the value into the contract's `message` storage variable).
      message = initMessage;
   }

   // A public function that accepts a string argument and updates the `message` storage variable.
   function update(string memory newMessage) public {
      string memory oldMsg = message;
      message = newMessage;
      emit UpdatedMessages(oldMsg, newMessage);
   }
}
```
![Screenshot_183](https://user-images.githubusercontent.com/81378817/205189977-5dbd79b9-3e41-4523-bc5d-22124508f3ba.jpg)
press `CTRL+X` `Y` then `ENTER` to save

## Configure Smartcontract

First, install the dotenv package in your project directory:
```bash
npm install dotenv --save
```
Create `.env` file, make sure you still on directory
```bash
sudo nano ~/hello-world/.env
```
Your environment file must be named `.env` or it won't be recognized as an environment file, Do not name it `process.env` or  anything else.

copy text below inside `.env` and replace 
* `https://eth-goerli.alchemyapi.io/v2/your-api-key` with your api from Blastapi or alchemy
* `your-metamask-private-key` with your private keys from Metamask
```bash
API_URL = "https://eth-goerli.alchemyapi.io/v2/your-api-key"
PRIVATE_KEY = "your-metamask-private-key"
```
![Screenshot_184](https://user-images.githubusercontent.com/81378817/205190658-2a324ea2-bc04-496d-9adf-6b75c9df1be8.jpg)
press `CTRL+X` `Y` then `ENTER` to save

## Install `Ethers.js`
* 'Ethers.js' is a library that makes it easier to interact and make requests to Ethereum by wrapping standard JSON-RPC methods with more user friendly methods.
* Hardhat makes it super easy to integrate Plugins for additional tooling and extended functionality. We’ll be taking advantage of the Ethers plugin for contract deployment (Ethers.js has some super clean contract deployment methods).

Make sure you still on project directory
```bash
npm install --save-dev @nomiclabs/hardhat-ethers "ethers@^5.0.0"
```

## Update `hardhat.config.js`
 adding several dependencies and plugins on `hardhat.config.js`
```bash
sudo nano ~/hello-world/hardhat.config.js
```
copy all text below inside `hardhat.config.js`
```bash
/**
* @type import('hardhat/config').HardhatUserConfig
*/

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
   solidity: "0.7.3",
   defaultNetwork: "goerli",
   networks: {
      hardhat: {},
      goerli: {
         url: API_URL,
         accounts: [`0x${PRIVATE_KEY}`]
      }
   },
}
```
![Screenshot_185](https://user-images.githubusercontent.com/81378817/205190960-7e9778e1-7ac2-43d9-aa76-cf69b5a69342.jpg)

press `CTRL+X` `Y` then `ENTER` to save
## Compile Smartcontract
```bash
npx hardhat compile
```

## create deploy script
Navigate to the /scripts folder and create a new file called `deploy.js`, adding the following contents to it
```bash
cd ~/hello-world//scripts
```
create scripts

```bash
sudo nano ~/hello-world/scripts/deploy.js
```
Copy content below inside `deploy.js`
```bash
async function main() {
   const HelloWorld = await ethers.getContractFactory("HelloWorld");

   // Start deployment, returning a promise that resolves to a contract object
   const hello_world = await HelloWorld.deploy("Hello World!");
   console.log("Contract deployed to address:", hello_world.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
```

## Deploy Smartcontract
```bash
cd
cd hello-world
npx hardhat run scripts/deploy.js --network goerli
```
You should see something like
```bash
Contract deployed to address: 0xCAFBf889bef0617d9209Cf96f18c850e901A6D61
```
![Screenshot_186](https://user-images.githubusercontent.com/81378817/205192727-b30a2c41-b2d1-4409-bff3-b7cbb08b9c60.jpg)

Congrats you have succesfull Deploy your Smartcontract
check your smartcontract https://goerli.etherscan.io/
