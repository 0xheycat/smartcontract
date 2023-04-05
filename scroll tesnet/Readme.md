![](https://www.gitbook.com/cdn-cgi/image/width=256,height=40,fit=contain,dpr=1,format=auto/https%3A%2F%2F1598178146-files.gitbook.io%2F~%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252FN0h75L1pUpWUzNW3fmKq%252Flogo%252Frt2RAT8adXWuFISsffHW%252Flogo_with_text.ff8e8db3.png%3Falt%3Dmedia%26token%3Dcb7bb7ec-60f7-4582-bd15-b24478e0c2c3)
### Official Documentation
* Scroll Doc https://guide.scroll.io/
* Github https://github.com/scroll-tech
* Twitter https://twitter.com/Scroll_ZKP
* Discord https://discord.com/invite/GQxeCTA4dJ
* Website https://scroll.io/

### Install requirement
```bash
sudo npm install -g yarn
```
```bash
sudo apt update
sudo apt install nodejs
```

### Install smartcontract
```bash
git clone https://github.com/scroll-tech/scroll-contract-deploy-demo.git
cd scroll-contract-deploy-demo 
```
Install Foundry
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```
Deploy your contract with Foundry,
Please replace following Data
* `<lock_amount>`  is the amount of TSETH to be locked in the contract. Try setting this to some small amount, like 0.0000001ether
* `<unlock_time>`  is the Unix timestamp after which the funds locked in the contract will become available for withdrawal. Try setting this to some Unix timestamp in the future, like `1696118400` (this Unix timestamp corresponds to October 1, 2023).
* `<your_private_key>` is private key from your wallet, try to use your private keys from wallet used on curent Testnet

```bash
forge create --rpc-url https://alpha-rpc.scroll.io/l2 \
  --value <lock_amount> \
  --constructor-args <unlock_time> \
  --private-key <your_private_key> \
  --legacy \
  contracts/Lock.sol:Lock
```
example
```bash
forge create --rpc-url https://alpha-rpc.scroll.io/l2 \
  --value 0.00000000002ether \
  --constructor-args 1696118400 \
  --private-key 0xabc123abc123abc123abc123abc123abc123abc123abc123abc123abc123abc1 \
  --legacy contracts/Lock.sol:Lock
```

![Screenshot_155](https://user-images.githubusercontent.com/81378817/202847318-8aba2476-dd1b-4a3e-a7e5-549ffae5b568.jpg)

Copy your txhash and find on explorer  
```bash
https://l2scan.scroll.io/tx/xxx
```
![Screenshot_156](https://user-images.githubusercontent.com/81378817/202847526-bae2b553-9133-4e98-9723-adf7dbff8778.jpg)

Dont forget to send feedback on [Discord](https://discord.com/invite/GQxeCTA4dJ)
Thank you
