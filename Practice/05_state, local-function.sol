// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract C3 {
		// 상태변수
    uint aa;
    uint aa2;
		
		// 아래의 uint a는 지역변수
    function add3(uint a) public returns(uint) {
        aa = 10;
        return aa+a;
    }
		/*
		오류 - view 함수는 state를 변형시킬 수 없음
    function add3(uint a) public view returns(uint) {
        aa = 10;
        return aa+a;
    }
		*/
    function add4() public returns(uint) {
        aa2 = aa2+1;
        return aa2;
    }
}