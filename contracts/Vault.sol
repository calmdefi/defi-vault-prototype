// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Vault is Ownable {
    IERC20 public token;

    mapping(address => uint256) public balances;
    uint256 public totalDeposits;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        token = IERC20(_tokenAddress);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");

        token.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
        totalDeposits += amount;
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        totalDeposits -= amount;
        token.transfer(msg.sender, amount);
    }

    function simulateYield(uint256 yieldAmount) external onlyOwner {
        require(yieldAmount > 0, "Yield must be > 0");

        totalDeposits += yieldAmount;
        uint256 yieldPerUser = yieldAmount / address(this).balance;

        //Distribute yield proportionally (for simplicity now evenly)
        for (uint256 i = 0; i < 10; i++) {
            // Later replace with iterable mapping / off-chain indexing
        }
    }
}