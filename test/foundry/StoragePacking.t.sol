// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";

import "../../contracts/StoragePacking.sol";

contract StoragePackingTest is Test {
    StoragePacking packing;

    function setUp() public {
        packing = new StoragePacking();
    }

    function testGetFullSlot() public {
        packing.setFullSlot(42);
        uint256 slot = packing.slot();
        assertEq(slot, 42);
    }

    function testGetOne() public {
        packing.setOne(1);
        uint128 one = packing.one();
        assertEq(one, 1);
    }

    function testGetOneSmart() public {
        packing.setFullSlot(1 | 2 << 128);
        uint256 slot = packing.slot();
        uint256 one = slot & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        assertEq(one, 1);
    }

    function testGetTwo() public {
        packing.setTwo(2);
        uint128 two = packing.two();
        assertEq(two, 2);
    }

    function testGetTwoSmart() public {
        packing.setFullSlot(1 | 2 << 128);
        uint256 slot = packing.slot();
        uint256 two = (slot >> 128) & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        assertEq(two, 2);
    }

    function testGetOneAndTwo() public {
        packing.setOne(1);
        packing.setTwo(2);
        (uint128 one, uint128 two) = packing.getOneAndTwo();
        assertEq(one, 1);
        assertEq(two, 2);
    }

    function testSetFullSlot() public {
        packing.setFullSlot(42);
        uint256 slot = packing.slot();
        assertEq(slot, 42);
    }

    function testSetOne() public {
        packing.setOne(1);
        uint128 slot = packing.one();
        assertEq(slot, 1);
    }

    function testSetTwo() public {
        packing.setTwo(2);
        uint128 slot = packing.two();
        assertEq(slot, 2);
    }

    function testSetOneAndTwo() public {
        packing.setOne(1);
        packing.setTwo(2);
        (uint128 one, uint128 two) = packing.getOneAndTwo();
        assertEq(one, 1);
        assertEq(two, 2);
    }

    function testSetOneAndTwoFull() public {
        packing.setOneAndTwo(1, 2);
        (uint128 one, uint128 two) = packing.getOneAndTwo();
        assertEq(one, 1);
        assertEq(two, 2);
    }

    function testSetOneAndTwoTrick() public {
        packing.setOneAndTwoTrick(1, 2);
        (uint128 one, uint128 two) = packing.getOneAndTwo();
        assertEq(one, 1);
        assertEq(two, 3);
    }
}
