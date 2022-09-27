// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract E {

		function sub(int a, int b) public view returns(int) {
        return a-b;
    }

    function div(uint a, uint b) public view returns(uint, uint) {
        return (a/b, a%b); // '/'와 '%'은 각각 몫과 나머지를 반환
    }
}