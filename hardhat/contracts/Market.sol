// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./MyToken.sol" ;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
contract Market {


    //Mapping to Keep Track of the Time Each Wallet Requests
    mapping(uint256 => uint256) public nftPrice ;
    address public contractOwner ;
    address public myTokenAddress ;

    modifier onlyOwner{
        require(msg.sender == contractOwner, "Only the contract owner can call this function");
        _;
    }
    constructor(address tokenAddress) {

        // myToken = MyToken(tokenAddress) ;
        myTokenAddress = tokenAddress ;
        contractOwner = msg.sender ;
    }

     // Buy Tokens
     function buy (uint256 tokenId) external payable {
        //Make sure they pay something 
         require(msg.value == nftPrice[tokenId], "You must pay correct price to buy a token");
         address currentOwner = IERC721(myTokenAddress).ownerOf(tokenId) ;
         IERC721(myTokenAddress).transferFrom(address(this), msg.sender, tokenId) ;
         uint _amount = msg.value * 9 / 10 ;
         address to = currentOwner ;
         (bool success, ) = to.call{value: _amount}("");
         require(success, "Failed to send Ether");
     }
     
     function sell(uint256 tokenId, uint256 price) external{
        address currentOwner = IERC721(myTokenAddress).ownerOf(tokenId) ;
        require(currentOwner == msg.sender, "You must own this token to sell it");
        require(IERC721(myTokenAddress).getApproved(tokenId) == address(this), "You must approve this marketplace to transfer this token");
        nftPrice[tokenId] = price ;
     }
    
    function withdraw() public onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Failed to send Ether");
    }

}
