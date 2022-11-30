// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
221128
어떤 숫자의 자릿수를 구해보세요
*/

contract numberLength {
    // n자리는 10의 n승으로 나눌 때부터 몫이 0 -> EX) 350 / 10^3 -> 몫이 0
    function getNumber(uint _a) public view returns(uint) {
        uint index; // 자리수 계산용
        // 자리수를 알아내기 위해 : 10으로 계속 나누어주기
        // EX) 12345 -> 5
        // EX) 1234 -> 4
        // EX) 123 -> 3
        // EX) 12 -> 2
        // EX) 1 -> 1
        while(_a != 0) { // _a 가 0이 아닐때까지 반복
            index++;
            _a = _a/10;
        } 
        return index;
    }

    uint[] numbers;
    // 숫자를 분리해보기 -> 12345 -> 1,2,3,4,5
    function divideNumber(uint _a) public returns(uint[] memory) {
        // uint[] memory numbers; // 👉 memory 로 설정된 배열에는 push 할 수 없다
        while(_a != 0) {
            numbers.push(_a%10);
            _a = _a/10;
        }
        return numbers;
    }

    uint[] reverse_numbers;
    // 분리한 숫자를 순서바꿔서 출력1
    function reverse(uint _a) public returns(uint[] memory) {
        uint a = numbers.length; // numbers 배열의 길이를 고정
        for(uint i; i < a; i++) { // a 의 길이만큼 계속 유지하고 반복
            reverse_numbers.push(numbers[numbers.length-1]);
            // numbers 배열안에 있는 값의 마지막요소
            numbers.pop();
        }
        return reverse_numbers;
    }

    uint[] reverse_numbers2;
    // 분리한 숫자를 순서바꿔서 출력2
    function reverse2() public returns(uint[] memory) {
        for(uint i=numbers.length; i > 0; i--) { 
            // numbers 의 길이를 기본값으로 설정 👉 0이 될때까지 반복
            reverse_numbers2.push(numbers[i-1]);
            // numbers 배열안에 있는 요소 push
        }
        return reverse_numbers2;
    }

    // 분리한 숫자를 순서바꿔서 출력3 (양쪽 대칭으로 변경)
    function reverse3(uint[] memory _arr) public returns(uint[] memory) {
        for(uint i; i < _arr.length/2; i++) {
            uint _m; // 임시 저장소
            _m = _arr[i]; // _arr 에서 i 번째 요소를 잠시 저장해둔다
            _arr[i] = _arr[_arr.length-i-1]; 
            // _arr[i] 에는 _arr 의 length-i-1 요소를 덮어씌우기
            _arr[_arr.length-i-1] = _m;
            // _arr 의 length-i-1 에 잠시 보관해둔 _a 를 덮어씌우기
        }
        return _arr;
    }
}