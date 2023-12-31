
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
