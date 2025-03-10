// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    // 1. Declare an event called `FundsDeposited` with parameters: `sender` and `amount`

    // 2. Declare an event called `FundsWithdrawn` with parameters: `receiver` and `amount`

    // 3. Create a public mapping called `balances` to tracker users balances

    // Modifier to check if sender has enough balance

    event FundsDeposited(address indexed sender, uint amount);

    event FundsWithdrawn(address indexed receiver, uint amount);

    mapping(address => uint256) public balances;


    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        _;
    }

    // Function to deposit Ether
    // This function should:
    // - Be external and payable
    // - Emit the `FundsWithdrawn` event


    function deposit() external payable {
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);

        // increment user balance in balances mapping 
        // emit suitable event
    }

    // Function to withdraw Ether
    // This function should:
    // - Be external
    // - Take one parameter: `amount`
    // - Use the `hasEnoughBalance` modifier
    // - Emit the `FundsWithdrawn` event

    function withdraw(uint amount) external hasEnoughBalance(amount) {

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit FundsWithdrawn(msg.sender, amount);
    }

    // Function to check the contract balance
    // This function should:
    // - Be public and view
    // - Return the contract's balance
    
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}