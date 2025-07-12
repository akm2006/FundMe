//SPDX-License-Identifier: MIT

pragma solidity 0.8.24;
import {AggregatorV3Interface} from "./AggregatorV3Interface.sol";
library PriceConverter{
    
    function getConversionRate(uint256 ethAmount) internal view returns(uint256){

        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18 ;
        return ethAmountInUsd;
    }

    function getPrice() internal view returns(uint256) {
      //ZKSync Sepolia testnet ETH/USD = 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
      (,int256 price,,,) = priceFeed.latestRoundData();

      return uint256( price *1e10);
    }


}