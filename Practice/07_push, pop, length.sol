// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* 
실습 순서 
1) pushNumber 이용해서 5개의 숫자 넣기
2) getArrayLength로 길이 구해보기
3) lastNumber로 마지막 숫자 확인하기
4) popNumber로 숫자 빼보기
5) 2,3번 다시 해보기 --> 길이 변경과 마지막 숫자 변경 잘 되었는지 확인하기
*/

contract AAA {
    uint a;
    uint[] array; // 배열 선언
		// 자료형[] 배열이름 <- 와 같이 배열 선언
    string[] sarray; //sarray에는 string형만 들어갈 수 있음



    // 배열에 숫자를 넣는 함수
    function pushNumber(uint a) public{
        array.push(a); //배열이름.push(변수)
    }

    // 배열에 있는 숫자 빼기 
    function popNumber() public {
        array.pop(); //배열이름.pop()
    }

    function pushString(string memory s) public {
        sarray.push(s);
    }

    // 배열 내 n번째 요소의 정보를 반환해주는 함수
		// 컴퓨터는 0이 1번째 
    function getNumber(uint _n) public view returns(uint) {
        return array[_n-1];
    }

    function getString(uint _n) public view returns(string memory) {
        return sarray[_n-1];
    }

    function getArrayLength() public view returns(uint) {
        return array.length; // 배열명.length
    }

    // 맨마지막 요소 받기
		// 0이 1번째이고, 배열의 길이가 n이라면 n번째는 n-1
    function lastNumber() public view returns(uint) {
        return array[array.length-1]; // array.length는 n array.length-1은 n-1
    }
}