// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract B {
    function forLoop() public view returns(uint){
        uint a; //지역변수
				//i 변수 선언 후 1부여, i가 11미만이면 계속 1씩 추가(i++)
        for(uint i=1; i<11; i++) {
            a = a+i; // a+=i
						//i는 1부터 10까지 (i<11을 만족할 때까지) 반복해서 코드실행
        }

        return a;
    }
}