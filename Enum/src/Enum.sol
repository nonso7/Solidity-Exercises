// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract ExampleEnum {
    /*
        This exercise assumes you understand how Enum works.
        1. The `isWeekend` function returns a bool when called.
    */

    enum DayOfWeek {
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday,
        Sunday
    }

    function isWeekend(uint256 index) public pure returns (bool) {
        // your code here
        require(index <= uint256(DayOfWeek.Sunday), "Not a weekend");

        DayOfWeek day = DayOfWeek(index);
        return (day == DayOfWeek.Saturday || day == DayOfWeek.Sunday);

    }

    
}
