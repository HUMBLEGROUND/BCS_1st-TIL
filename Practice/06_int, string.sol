// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract D {
    // 숫자형
    uint a;
    // 문자형
    string b;
    string c = "a";
		// 음수 표현이 가능한 int형
    int d = -2;

    function getC() public view returns(string memory){
        return c;
    }

    function getC2() public returns(string memory) {
        c = "d";
        return c;
    }

    function getD() public view returns(int) {
        return d;
    }
}