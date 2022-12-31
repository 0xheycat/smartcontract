# Official Documentation
* doc https://taiko.xyz/docs/
* Feedback https://github.com/orgs/taikoxyz/discussions/new?category=feedback&title=Testnet%20feedback%20form&body=%23+Friction+log%0D%0A-+TODO%0D%0A%0D%0A%23+Other+notes%0D%0A-+TODO%0D%0A

# Preparation
* install foundry
```bash
curl -L https://foundry.paradigm.xyz | bash
```
![Screenshot_288](https://user-images.githubusercontent.com/81378817/210141631-d70a8ab0-e382-481f-bc4c-b986585aa824.jpg)

```bash
foundryup
```
![Screenshot_289](https://user-images.githubusercontent.com/81378817/210141834-180b6375-de73-4797-b2c9-0c72b3abea6f.jpg)

# Setting smartcontract

```bash
forge init hello_foundry && cd hello_foundry
```
![Screenshot_290](https://user-images.githubusercontent.com/81378817/210142122-09f9d4dc-cdec-46a9-ba1a-7e2c92d4b5b5.jpg)

please replace `<YOUR_PRIVATE_KEY>` with your private keys from Metamask/other wallet used from testnet 

```bash
forge create --legacy --rpc-url https://l2rpc.a1.taiko.xyz --private-key <YOUR_PRIVATE_KEY> src/Counter.sol:Counter
```
when succesfull, you will see like picture below
![Screenshot_291](https://user-images.githubusercontent.com/81378817/210145175-db7549ee-38ea-4b3d-aa15-b8128343c606.jpg)

# Source
* source https://taiko.xyz/docs/alpha-1-testnet/deploy-a-contract
* Source other testnet from Taiko https://twitter.com/OlimpioCrypto/status/1608823875013603328
