// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AAA {
    /*
    a --- aa - 10
      |-- ab - 15
      |-- ac - 20

    b --- aa - 20
       |--ab - 10
       |--ac - 15

    c --- aa - 30
       |--ab - 25
       |--ac - 40
    */

    // map[index] = _a;
    // return map[_index];
    mapping(string => mapping(string => uint)) balance;

    function setAllowedBalance(string memory _a, string memory _b, uint _c) public {
        balance[_a][_b] = _c;
    }

    function getAllowedBalance(string memory _a, string memory _b) public view returns(uint) {
        return balance[_a][_b];
    }
}