// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AAA {
    string[] nameList;

    function pushName(string memory _name) public {
        nameList.push(_name);
    }

    function getLength() public view returns(uint) {
        return nameList.length;
    }

    function getName(uint a) public view returns(string memory) {
        return nameList[a-1];
    }
}