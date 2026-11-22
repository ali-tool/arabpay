// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract ArabPay {
    IERC20 public token;
    address public owner;

    event PaymentSent(address indexed from, address indexed to, uint256 amount);

    constructor(address _token) {
        token = IERC20(_token);
        owner = msg.sender;
    }

    function sendPayment(address _to, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        require(_to != address(0), "Invalid address");
        require(token.transferFrom(msg.sender, _to, _amount), "Transfer failed");
        emit PaymentSent(msg.sender, _to, _amount);
    }

    function getBalance(address _addr) external view returns (uint256) {
        return token.balanceOf(_addr);
    }
}