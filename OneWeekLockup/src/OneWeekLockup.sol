// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */
    mapping(address => uint256) public balance;
    mapping(address => uint256) public lastDepositTime;
    uint256 constant withdrawalDate = 7 days;

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return balance[user];
    }

    function depositEther() external payable {
        /// add code here
        require(msg.value > 0, "deposit should be greater than zero");
        balance[msg.sender] += msg.value;
        lastDepositTime[msg.sender] = block.timestamp;

    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        require(amount > 0);
         require(balance[msg.sender] >= amount, "Insufficient balance");
        require(
            block.timestamp >= lastDepositTime[msg.sender] + withdrawalDate,
            "Withdrawal not allowed yet"
        );
        balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
