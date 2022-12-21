// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract StoragePacking {
    constructor() {
    }

    uint128 public one;
    uint128 public two;

    uint256 public slot;

    function getOneAndTwo() public view returns (uint128, uint128) {
        return (one, two);
    }

    function setOne(uint128 value) public {
        one = value;
    }

    function setTwo(uint128 value) public {
        two = value;
    }

    function setOneAndTwo(uint128 one_, uint128 two_) public {
        one = one_;
        two = two_;
    }

    function setOneAndTwoTrick(uint128 one_, uint128 two_) public {
        one = one_;
        slot = 42;
        two = two_ + one_;
    }

    function setFullSlot(uint256 value) public {
        slot = value;
    }
}
