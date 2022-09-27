// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract C2 {
    function add(uint a, uint b) public view returns(uint) {
        return a+b;
    }

    /* 
    오류 - 1
    function add(uint a, uint b) public view returns(uint) {
        return a+b;
    }
    오류 - 2
    function add(uint a, uint b) public returns(uint) {
        return a+b;
    }

    오류 - 3
    function add(uint a, uint b) public view returns(uint, uint) {
        return (a+b, a+a+b);
    }

    오류 - 4
    function add(uint a, uint c) public view returns(uint) {
        return a+c;
    }
    */
    function add(uint a, uint b, uint c) public view returns(uint) {
        return a+b;
    }

}