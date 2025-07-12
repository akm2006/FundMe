# 🪙 FundMe Smart Contract

A simple crowdfunding smart contract built in Solidity. This contract allows users to fund with ETH, and the owner can withdraw the funds. It uses Chainlink Price Feeds to enforce a minimum funding amount in USD.

---

## 🚀 Features

- Users can fund the contract with ETH
- Funding is only accepted if it meets a minimum USD threshold
- The contract fetches real-time ETH/USD price using Chainlink
- Only the contract owner can withdraw funds
- Automatically handles direct ETH transfers via `receive` and `fallback` functions
- Gas-optimized with `immutable`, `constant`, and custom errors

---

## 📄 Contract Overview

### `fund()`
Allows anyone to send ETH to the contract. Requires the amount to be greater than or equal to `$MINIMUM_USD` (converted to ETH using Chainlink).

### `withdraw()`
Only callable by the contract owner. Resets funder balances and sends the full contract balance to the owner.

### `onlyOwner` (modifier)
Restricts certain functions to the deployer (owner).

### `receive()` and `fallback()`
Allow ETH to be sent directly to the contract without calling `fund()` explicitly.

---

## 📦 Dependencies

- **Solidity 0.8.24**
- **Chainlink Price Feeds**
- `PriceConverter` library (used to convert ETH amount to USD)

---

## 📈 Price Feed

This contract relies on Chainlink price feeds to get the latest ETH/USD price. Update the address inside `PriceConverter.sol` based on the network:

- Sepolia ETH/USD: `0x694AA1769357215DE4FAC081bf1f309aDC325306`
- [Other Addresses](https://docs.chain.link/data-feeds/price-feeds/addresses?page=1&testnetPage=1)

---

## 📚 Files

- `FundMe.sol`: Main smart contract
- `PriceConverter.sol`: Library for converting ETH to USD
- `AggregatorV3Interface.sol`: Interface to Chainlink price feed

---

## ⚙️ Deployment

You can deploy this contract using:

- **Remix IDE**
- **Hardhat**
- **Foundry**

Make sure you provide the correct Chainlink price feed address for your network.

---

## 🔐 Security Features

- Uses `immutable` for owner — gas optimization
- Custom error `NotOwner()` to reduce gas usage
- Uses `call` (recommended over `transfer` and `send`)
- Proper zeroing of mapping and array before withdrawal

---

## 📜 License

[MIT](https://choosealicense.com/licenses/mit/)

