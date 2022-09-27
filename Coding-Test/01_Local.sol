// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* 상태변수 10을 선언하라. 
상태 변수를 10을 곱하여 반환하는 함수 1개와 
local에서만 10을 더한 값을 반환하는 함수 1개를 구현하세요. */

contract AA {
    uint aa = 10;

    function AAA() public view returns(uint) {
        return aa+10;
    }

    function AAA2() public returns(uint) {
        aa = aa*10;
        return aa;
    }

    function AAA3()  public view returns(uint) {
        return aa;
    }
}