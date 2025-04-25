// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBankV2 {
    /// used to store the balance of users
    mapping(address => uint256) public balances;

    /// @notice deposit ether into the contract
    function addEther() external payable {
        balances[msg.sender] += msg.value; // ✅ use msg.sender
    }

    /// @notice used to withdraw ether from the contract
    function removeEther(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance"); // ✅ use msg.sender
        balances[msg.sender] -= amount; // ✅ subtract from msg.sender balance

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send");
    }
}
