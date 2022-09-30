// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
배열 안에 값을 넣고 delete를 했을 때와 pop을 했을 때의 차이점 분석

delete는 해당 값을 0으로 바꾸는 반면 
pop은 마지막 요소를 아예배열에서제외시킴
delete는 실행해도 배열의 길이가 변하지 않고, 
pop은 배열의 길이가 1감소

1. push 함수로 2,4,5,6,8,10 push 
2. getLength 함수로 길이가 5임을 확인
3. getNumber로 1,2,3,4,5번째 각각 확인
4. renew(3, 10)으로 3번째 숫자 10으로 바꾸기
5. getLength로 길이 확인(5가 나옴), getNumber(3)해서 결과값 10확인 
6. popNum하고 getLength해서 길이 확인(4)
*/

contract A {
    uint[] A; //숫자형 배열


    //배열에 값 a 넣기
    function push(uint a) public {
        A.push(a);
    }

    //a번째 요소 b로 갱신하기
    function renew(uint a, uint b) public {
        delete A[a-1]; // a-1번 요소 0으로 초기화
        A[a-1] = b;    // a-1번 요소 b값으로 변환
    } // ex) 3, 10 입력 👉 3번째 요소 10으로 변경

    //배열내 요소값 받아내기
    function getNumber(uint a) public view returns(uint) {
        return A[a-1];
    }

    //배열 길이 받기
    function getLength() public view returns(uint) {
        return A.length;
    }

    //요소를 pop하기, 배열의 길이가 줄어듬
    function popNum() public returns(uint){
        A.pop();
        return A[A.length-1]; // 배열내 가장 마지막 요소를 받아오기
    }
}