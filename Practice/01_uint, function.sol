// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A {
		// uint ""변수명""  --> 숫자형 변수 선언법
    
    uint number=1; 
    /*
		uint는 자동으로 uint256로 인식
		오류(용량 초과) : uint8 number2=256; 
		8비트 -> 16진수-2자리 -> 0~255까지 표현 가능
		*/

    function getNumber() public view returns(uint) {
        return (number);
    }

    function getNumber2() public view returns(uint, uint) {
        return (number, 2);
    }

    function getNumber3() public view returns(uint, uint, uint) {
        return(number, 10, 15);
    }

}