# Custom Time-Locked Vesting Smart Contract

A secure, gas-optimized, production-ready Solidity vesting contract featuring an absolute 1-year cliff lockup with zero administrative backdoors.

## Technical Specifications
- **Solidity Version:** ^0.8.20
- **Framework:** Hardhat
- **Security:** Completely immutable state parameters, protected against reentrancy using the Checks-Effects-Interactions pattern, and utilizes custom errors over string requires to save execution gas.

## Mandatory Testing Suite Scenarios Handled:
1. **Early Access Rejection:** Simulates a withdrawal attempt at Month 11 to guarantee the contract cleanly reverts with `LockPeriodActive()`.
2. **Unauthorized Wallet Defenses:** Verifies that external malicious actors cannot manipulate state or hijack assets.
3. **Time-Warp Success:** Uses `evm_increaseTime` to warp past the 365-day mark, ensuring the beneficiary receives 100% of the locked token balance.

## Quick Start for Local Testing
```bash
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
npx hardhat test
