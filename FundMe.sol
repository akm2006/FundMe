// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConverter.sol";


error NotOwner() ;

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 1;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable  i_owner;

    constructor() {
        i_owner = msg.sender ;
    }

    function fund() public payable {


        require(msg.value.getConversionRate() >= (MINIMUM_USD * 1e18) , "didn't send enough ETH"); // 1e18 = 1*10^18 wei = 1 ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {

        

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++)
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0 ;
        }

        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed") ;
    }

    modifier onlyOwner(){

        // require(msg.sender == i_owner, "Sender is not owner") ;
        if(msg.sender != i_owner)
        {
            revert NotOwner();
        }
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
     }
}