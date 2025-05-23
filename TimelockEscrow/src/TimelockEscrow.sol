// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */
    struct Escrow {
        uint256 amount;
        uint256 depositTime;
    }



    mapping(address => Escrow) public buyerDetails;

    constructor() {
        seller = msg.sender;
    }

    
    /**
     * creates a buy order between msg.sender and seller
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        require(msg.value > 0, "Deposit should be greater than zero");
        buyerDetails[msg.sender] = Escrow(msg.value, block.timestamp);
      

    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(msg.sender == seller, "You are not the seller");
        require(buyerDetails[buyer].amount > 0, "Buyer hasn't Deposited any eth");
        uint256 buyerDepositTime = buyerDetails[buyer].depositTime;
        uint256 currentTime = block.timestamp;
        uint256 duration = currentTime - buyerDepositTime;

        uint256 threeDays = 24 * 3 * 60 * 60;

        require(duration >= threeDays, "You can only withdraw after 3 days");
        payable(seller).transfer(buyerDetails[buyer].amount);

        buyerDetails[buyer].amount = 0;
    }

    /**
     * allows buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        require(buyerDetails[msg.sender].amount > 0, "You havent Deposited Any ETH in the past");
        uint256 buyerDepositTime = buyerDetails[msg.sender].depositTime;
        uint256 currentTime = block.timestamp;
        uint256 duration = currentTime - buyerDepositTime;

        uint256 threeDays = 24 * 3 * 60 * 60;

        require(duration < threeDays);

        payable(msg.sender).transfer(buyerDetails[msg.sender].amount);

        buyerDetails[msg.sender].amount = 0;
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return buyerDetails[buyer].amount;
    }
}
