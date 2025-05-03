// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract FizzBuzz {
    function fizzBuzz(uint256 n) public pure returns (string memory) {
        // if n is divisible by 3, return "fizz"
        // if n is divisible by 5, return "buzz"
        // if n is divisible by 3 and 5, return "fizz buzz"
        // otherwise, return an empty string
        
        if (n % 3 == 0 && n % 5 == 0) {
            return "fizz buzz";
        } else if (n % 3 == 0) {
            return "fizz";
        } else if (n % 5 == 0) {
            return "buzz";
        } else {
            return "";
        }
    }
}


// This follows a key programming principle: check the most specific condition first, 
// then move to more general cases. 
// Since a number being divisible by both 3 and 5 is more specific than being divisible by just one of them, 
// we check that condition first.