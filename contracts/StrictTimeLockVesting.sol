// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract StrictTimeLockVesting {
    error LockPeriodActive(uint256 currentTimestamp, uint256 unlockTimestamp);
    error NoTokensAvailable();
    error TransferFailed();

    IERC20 public immutable token;
    address public immutable beneficiary;
    uint256 public immutable unlockTimestamp;

    event TokensReleased(address indexed beneficiary, uint256 amount);

    constructor(address _token, address _beneficiary) {
        token = IERC20(_token);
        beneficiary = _beneficiary;
        unlockTimestamp = block.timestamp + 365 days; 
    }

    function release() external {
        if (block.timestamp < unlockTimestamp) {
            revert LockPeriodActive(block.timestamp, unlockTimestamp);
        }

        uint256 amount = token.balanceOf(address(this));
        if (amount == 0) {
            revert NoTokensAvailable();
        }

        emit TokensReleased(beneficiary, amount);

        if (!token.transfer(beneficiary, amount)) {
            revert TransferFailed();
        }
    }
}
