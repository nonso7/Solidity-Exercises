// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    address public winner;
    uint256 public highestBet;
    uint256 public endTime;

    function bet() public payable {
        // Make sure some ETH was sent
        require(msg.value > 0, "Must send some ETH to bet");
        
        // Check if this bet is higher than the current highest
        if (msg.value > highestBet) {
            // Update the highest bet amount
            highestBet = msg.value;
            
            // Update the potential winner
            winner = msg.sender;
            
            // Update the end time (current time + 1 hour)
            endTime = block.timestamp + 1 hours;
        }
    }

    function claimPrize() public {
        // Check if the betting period has ended
        require(block.timestamp >= endTime, "Betting period not over yet");
        
        // Check if the caller is the winner
        require(msg.sender == winner, "Only the winner can claim the prize");
        
        // Get the contract balance
        uint256 prize = address(this).balance;
        
        // Reset the contract state
        highestBet = 0;
        winner = address(0);
        endTime = 0;
        
        // Transfer the prize to the winner
        // Using call with value transfer is the recommended way
        (bool success, ) = payable(msg.sender).call{value: prize}("");
        require(success, "Transfer failed");
    }
}