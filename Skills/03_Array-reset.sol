// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AA {
    uint[] a;
    function pushNumber(uint _a) public {
        a.push(_a);
    }

    function erase() public {
        uint[] memory b;
        a=b;
    }

    function getLength() public view returns(uint) {
        return a.length;
    }
}