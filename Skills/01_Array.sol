// SPDX-License-Identifier: GPL-3.0

/*
이 코드에는 배열을 사용할 때 필요한 대부분의 내용들이 들어있음.

값 넣기(push), 
특정 위치의 값 호출(getNumber), 
배열 길이 호출(getLength), 
특정 위치의 요소 지우기(removeNum)
맨 마지막 요소 지우기(pop)

에 대한 코드가 포함됨. 
*/

pragma solidity >=0.7.0 <0.9.0;


contract A {
    uint[] A; //숫자형 배열

    //배열에 값 a 넣기
    function push(uint a) public {
        A.push(a);
    }

    //a번째 요소 b로 갱신하기
    function renew(uint a, uint b) public {
        delete A[a-1];
        A[a-1] = b;
    }

    //배열내 요소값 받아내기
    function getNumber(uint a) public view returns(uint) {
        return A[a-1];
    }

    //배열 길이 받기
    function getLength() public view returns(uint) {
        return A.length;
    }

		// 특정 위치의 요소의 빼기
    function removeNum(uint a) public {
        // A[1] = A[2], A[2] = A[3], A[3] = A[4] .... A[n-1] = A[n], pop()
        for(a; a<A.length; a++) {
            A[a-1]=A[a];
        }
        A.pop();
    }

    //요소를 pop하기, 맨 마지막 요소 빼기
    function popNum() public returns(uint){
        A.pop();
        return A[A.length-1];
    }
}