// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external view returns (uint256) {
        // your code here
        (bool ok, bytes memory result1) = _priceOracle1.staticcall(abi.encodeWithSignature("price()"));
        require(ok, "called failed");

        (bool ok2, bytes memory result2) = _priceOracle2.staticcall(abi.encodeWithSignature("price()"));
        require(ok2, "called failed");

        uint256 price1 = abi.decode(result1, (uint256));
        uint256 price2 = abi.decode(result2, (uint256));
        
        // Return the lower price
        return price1 < price2 ? price1 : price2;
    }
}


// In Solidity, view functions promise not to modify state.
// The regular .call() method is designed for state-changing operations and can potentially modify state. When used inside a view function, this creates a contradiction because:

// The function declares it won't modify state (via the view keyword)
// But it's using a method that could modify state (.call())


// To make external calls from view functions, you need to use .staticcall() instead, which guarantees no state modifications.

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
