// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;

    constructor() payable {
        
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        uint256 currentTime = block.timestamp;
        uint256 timeElapsed = currentTime - depositedTime;
        
        // 24 hours in seconds
        uint256 twentyFourHours = 24 * 60 * 60;
        
        if (timeElapsed >= twentyFourHours) {
            // After 24 hours, nothing can be withdrawn
            return;
        }
        
        // Calculate the withdrawable amount
        // Decreases by 0.0011574 ether per second (which is 0.0011574% of 1 ether per second)
        uint256 reductionPerSecond = 11574000000000;
        
        // Total reduction = timeElapsed * reductionPerSecond
        uint256 totalReduction = timeElapsed * reductionPerSecond;
        
        // Withdrawable amount = 1 ether - totalReduction
        uint256 amount = 1 ether - totalReduction;
        
        // Transfer the calculated amount to the caller
        payable(msg.sender).transfer(amount);
       
    }
}