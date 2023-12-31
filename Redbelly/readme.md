
Welcome to this tutorial, where we will walk you through the process of developing an awesome NFT (Non-Fungible Token) smart contract on Remix. By the end of this tutorial, you will have a solid understanding of how to create NFT contracts and implement them using Remix.

#### Prerequisites:
1. Familiarity with Solidity and Ethereum blockchain basics.
2. An account on [Remix IDE](https://remix.ethereum.org/).


#### Step 1: Setting up a New Remix Project
1. Open the Remix IDE in your browser. [Remix IDE](https://remix.ethereum.org/)
2. Create a new file by clicking on the "+" button on the left sidebar.

![Screenshot_34](https://github.com/fatalbar/smartcontract/assets/81378817/b53e8a11-19d5-44ed-89d0-eee1085ab697)


3. Name the file `NFT.sol`, which will contain our smart contract code.

#### Step 2: Importing Simple Libraries and Initial Contract Setup
1. Start by importing the `ERC721` code. These code provide the basic functionality required for creating NFTs and managing collections.
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MEOWBORED {
string public name;
string public symbol;

struct Token {
string name;
uint256 tokenId;
address owner;
}
```
- `SPDX-License-Identifier: MIT` specifies the license for the contract.
- `pragma solidity ^0.8.0;` sets the version of Solidity that the contract is written in.

The contract has two public string variables defined:
- `name`: Represents the name of the token.
- `symbol`: Represents the symbol of the token.

Furthermore, the contract defines a struct called `Token` with the following properties:
- `name`: Represents the name of the token.
- `tokenId`: Represents the unique identifier of the token.
- `owner`: Represents the address of the token's owner.

Note that the visibility of these variables is set to public, allowing them to be read directly from the contract.

2. involves two mappings in a smart contract.
```solidity
mapping(uint256 => Token) private tokens;
mapping(address => mapping(uint256 => bool)) private ownedTokens;
```
* `mapping(uint256 => Token) private tokens;`
This mapping is named `tokens` and it maps a `uint256` key to a `Token` value. It is marked as `private`, making it accessible only within the smart contract. Here, `uint256` represents the token ID, and `Token` represents the type or structure that each token possesses. This mapping can be used to store and retrieve tokens based on their unique IDs.

* `mapping(address => mapping(uint256 => bool)) private ownedTokens;`
This mapping is named `ownedTokens` and it uses a two-level mapping. It maps an `address` as the first-level key to another mapping, where the second-level key is a `uint256`. The value stored at the second level is a `bool` type. Again, this mapping is marked as `private`. This structure allows multiple addresses to own multiple tokens, and the `bool` value indicates ownership status.

In summary, the `tokens` mapping is used to track tokens by their IDs, while the `ownedTokens` mapping is used to keep track of token ownership by different addresses.

#### Step 3: Implementing NFT Metadata and Minting Functions
1. Add the `Transfer` is typically used in the context of Non-Fungible Tokens (NFTs) or token-based systems to track the transfer of tokens from one address to another. The event has three parameters:

```solidity
event Transfer(address indexed from, address indexed to, uint256 tokenId);
```

* `address indexed from` represents the address from where the tokens are being transferred. The "indexed" keyword indicates that this parameter can be used for filtering events when querying the blockchain.

* `address indexed to` represents the address to which the tokens are being transferred. Like the "from" parameter, this parameter can also be used for filtering events.

* `uint256 tokenId` represents the unique identifier of the token being transferred. It is typically an unsigned integer value that uniquely identifies a specific NFT or token in the system.

When this `Transfer` event is triggered and emitted within a smart contract, it signifies that a token transfer has occurred between two addresses. The event logging makes it possible to track and monitor token movements within the blockchain, providing transparency and accountability for users.

2. Add a `constructor` parameter include `_name` of type `string` and `_symbol` of type `string` of our code

```solidity
constructor(string memory _name, string memory _symbol) {
name = _name;
symbol = _symbol;
}
```
* `constructor` is special function that is executed only once during the contract deployment. It is used to initialize the state variables of the contract.
* The constructor takes two parameters: `_name` of type `string` and `_symbol` of type `string`. These two parameters represent the name and symbol of a token or asset that the smart contract is meant to represent.

* Inside the constructor, the `_name` parameter is assigned to the `name` state variable, and the `_symbol` parameter is assigned to the `symbol` state variable. By assigning these values, the contract initializes its internal representation of the token with the provided name and symbol.

Once the constructor is executed during contract deployment, the name and symbol values will be set and stored in the contract's state, allowing other functions within the smart contract to access and use those values as needed.

3. Add two functions in a smart contract: `mint` and `transfer`.
```solidity
function mint(string memory _name, uint256 _tokenId) external {
require(!existsToken(_tokenId), "Token with this ID already exists");

Token memory newToken = Token({
name: _name,
tokenId: _tokenId,
owner: msg.sender
});

tokens[_tokenId] = newToken;
ownedTokens[msg.sender][_tokenId] = true;
}

function transfer(address _to, uint256 _tokenId) external {
require(existsToken(_tokenId), "Token with this ID does not exist");
require(ownerOf(_tokenId) == msg.sender, "You are not the owner of this token");
```

* The `mint` function is used to create a new token with a given name and identifier. It takes two parameters: `_name` (a string representing the name of the token) and `_tokenId` (a unique identifier for the token). 

* First, the function checks if a token with the specified `_tokenId` already exists by calling the `existsToken` function. If a token with the same identifier already exists, it throws an error and stops executing.

* Next, a new `Token` object is created with the provided `_name`, `_tokenId`, and the account address of the message sender (`msg.sender`) as the owner of the token.

* The newly created token is then stored in the `tokens` mapping, where the key is the `_tokenId` and the value is the `Token` object. Additionally, the mapping `ownedTokens` is used to keep track of the tokens owned by each address. Therefore, the ownership of the newly minted token is assigned to the sender's address.

* The `transfer` function is used to transfer a token from the sender's address to another address (`_to`). It takes two parameters: `_to` (the address to transfer the token to) and `_tokenId` (the identifier of the token to be transferred).

* The function starts by checking if a token with the specified `_tokenId` exists by calling the `existsToken` function. If the token does not exist, it throws an error.

* Then, it verifies if the sender of the message (`msg.sender`) is the current owner of the token by comparing it to the result of the `ownerOf` function. If the sender is not the owner, an error is thrown.

If the token exists and the sender is the owner, the ownership of the token is transferred to the `_to` address by updating the relevant mappings. The `ownedTokens` mapping for the sender's address is updated to remove the token, and the `ownedTokens` mapping for the `_to` address is updated to include the transferred token.

4. Create  function to manages ownership and transfer of tokens
```solidity
// Transfer token
ownedTokens[msg.sender][_tokenId] = false;
ownedTokens[_to][_tokenId] = true;
tokens[_tokenId].owner = _to;
emit Transfer(msg.sender, _to, _tokenId);
}

function existsToken(uint256 _tokenId) public view returns (bool) {
return tokens[_tokenId].owner != address(0);
}

function ownerOf(uint256 _tokenId) public view returns (address) {
require(existsToken(_tokenId), "Token with this ID does not exist");
return tokens[_tokenId].owner;
}
}
```
* `transferToken`: This function transfers ownership of a token from `msg.sender` (the caller of the function) to another address `_to`. It updates the `ownedTokens` mapping to reflect the change in ownership by setting `ownedTokens[msg.sender][_tokenId]` to `false` (indicating `msg.sender` no longer owns the token) and `ownedTokens[_to][_tokenId]` to `true` (indicating `_to` becomes the new owner). It also updates the `owner` attribute of the token with ID `_tokenId` to `_to` in the `tokens` mapping. Finally, it emits a `Transfer` event to notify listeners about the token transfer.

* `existsToken`: This function checks whether a token with the given ID `_tokenId` exists. It returns `true` if the `owner` attribute of the token in the `tokens` mapping is not equal to `address(0)` (indicating a valid owner address is assigned). Otherwise, it returns `false`.

* `ownerOf`: This function returns the owner address of the token with ID `_tokenId`. It first checks if the token exists by calling the `existsToken` function. If the token exists, it returns the `owner` attribute from the `tokens` mapping. Otherwise, it reverts with an error message.

Overall, this smart contract provides functionality to transfer tokens, check the existence of a token, and get the owner of a token.

5. Finnaly we Create awesome NFT smart contract, this final code
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MEOWBORED {
string public name;
string public symbol;

struct Token {
string name;
uint256 tokenId;
address owner;
}

mapping(uint256 => Token) private tokens;
mapping(address => mapping(uint256 => bool)) private ownedTokens;

event Transfer(address indexed from, address indexed to, uint256 tokenId);

constructor(string memory _name, string memory _symbol) {
name = _name;
symbol = _symbol;
}

function mint(string memory _name, uint256 _tokenId) external {
require(!existsToken(_tokenId), "Token with this ID already exists");

Token memory newToken = Token({
name: _name,
tokenId: _tokenId,
owner: msg.sender
});

tokens[_tokenId] = newToken;
ownedTokens[msg.sender][_tokenId] = true;
}

function transfer(address _to, uint256 _tokenId) external {
require(existsToken(_tokenId), "Token with this ID does not exist");
require(ownerOf(_tokenId) == msg.sender, "You are not the owner of this token");

// Transfer token
ownedTokens[msg.sender][_tokenId] = false;
ownedTokens[_to][_tokenId] = true;
tokens[_tokenId].owner = _to;
emit Transfer(msg.sender, _to, _tokenId);
}

function existsToken(uint256 _tokenId) public view returns (bool) {
return tokens[_tokenId].owner != address(0);
}

function ownerOf(uint256 _tokenId) public view returns (address) {
require(existsToken(_tokenId), "Token with this ID does not exist");
return tokens[_tokenId].owner;
}
}
```
#### Step 4: Testing the Smart Contract on Remix
1. Compile the smart contract by clicking on the "Solidity Compiler" tab in Remix.
 
![Screenshot_35](https://github.com/fatalbar/smartcontract/assets/81378817/66269eb4-12dd-4f3d-81a4-d2030e49e31d)

2. Once successfully compiled, switch to the "Deploy & Run Transactions" tab.
3. Select the Metamask from the dropdown menu, 

![Screenshot_36](https://github.com/fatalbar/smartcontract/assets/81378817/5ecc036e-8551-4445-9da2-9b394b1daab8)

4. Seting Metamask RPC into Redbelly Devnet

![Screenshot_37](https://github.com/fatalbar/smartcontract/assets/81378817/2253e1ea-cd64-4d9f-ac7f-a1497601a416)

5. Before we Deploying our Smart Contract Setting `name` and `symbol` your NFT

![Screenshot_38](https://github.com/fatalbar/smartcontract/assets/81378817/88fd5b44-a8e8-42e5-b79c-ffb95023c71b)

6. click on "Deploy" to deploy the smart contract. and confirm 

![Screenshot_39](https://github.com/fatalbar/smartcontract/assets/81378817/c8157dea-10ca-48c4-a510-45a2b672dff2)


🎉🎉 Congratulations! You have successfully created an awesome NFT smart contract using Remix. Now you can mint NFTs, set their metadata, and deploy the contract on Redbelly Devnet networks.

Note: Remember to perform thorough testing and security audits before deploying any smart contract to the mainnet.

Feel free to enhance this smart contract with additional functionalities, such as implementing royalties, extended metadata, or marketplace integrations. Happy coding and exploring the vast world of NFTs!


