// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AAA {
    mapping(uint => uint) map; //maaping(자료형 => 자료형) map이름;
    mapping(string => uint) map2;
    mapping(address => uint) map3;

    function push(uint index, uint _a) public {
        map[index] = _a;
    }

    function push2(string memory _a, uint _b) public {
        map2[_a] = _b;
    }

    function push3() public {
        map3[msg.sender] = msg.sender.balance;
    }

    function get(uint _index) public view returns(uint) {
        return map[_index];
    }

    function get2(string memory _a) public view returns(uint) {
        return map2[_a];
    }

    function get3() public view returns(uint) {
        return map3[msg.sender];
    }
}