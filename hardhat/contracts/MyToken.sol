// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract MyToken is ERC721 {


    //Mapping to Keep Track of the Time Each Wallet Requests
    
    constructor(string memory _name, string memory symbol) ERC721(_name, symbol) {}

    function mint(uint256 id) public {
        _mint(msg.sender, id);
    }
    function burn(uint256 id) public {
        _burn(id);
    }
}
