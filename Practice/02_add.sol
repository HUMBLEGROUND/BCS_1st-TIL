// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract B {

		/*
		function ""함수이름""(INPUT값들) public view returns(OUTPUT값들) {
			//// CODE
			//// CODE
		}
		*/
    function add(uint a, uint b) public view returns(uint) {
        return a+b; //정의한 OUTPUT 형태와 실제 반환 값의 형태가 일치해야함
    }

    function add2(uint a, uint b, uint c) public view returns(uint) {
        return a+b+c;
    }
}