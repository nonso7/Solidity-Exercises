// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Emitter {
    /* This exercise assumes you know how events work.
        1. Create a event that emits two non-indexed values; `address` and `uint256`.
        2. Emit the event in the emitEvent function below
        3. The name of the event must be `Trigger`
    */
   event Trigger(address _address, uint256 _num);

    function emitEvent(address _addr, uint256 _num) public {
        // your code here
        emit Trigger(_addr, _num);
    }
}
