// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract password {
    /*
    221128
    은행 금고의 비밀번호는 4자리 입니다. 
    은행도 여러분들의 비밀번호는 모르며 검증만 할 수 있습니다(해시 함수의 결과값 활용). 
    각 자리에는 0~9까지의 숫자가 들어갈 수 있습니다.

    여러분은 강도입니다. 전체 비밀번호는 모르는 상태이며, 
    앞 자리 2개의 숫자가 0,4 인 것을 알고 있습니다. 
    실제 비밀번호를 알아내는 함수를 구현하세요.

    실제 비밀번호 : 0429
    */

    bytes32 PW;

    constructor() {
        PW = makePW(0,4,2,9);
    }

    // 비밀번호 만드는 함수
    function makePW(uint _a, uint _b, uint _c, uint _d) public returns(bytes32){
        return keccak256(abi.encodePacked(_a, _b, _c, _d));
    }

    bytes32 PW2; // 우리가 만드는 비밀번호
    // 0과 4를 알고 있는 상황
    function makePW2() public returns(bool, uint, uint){
        // 0부터 9까지 다 넣어보기 -> for문을 돌려서 (2번)
        /*
        00 01 02 03 04 05 ``````` 32 33 34 35 36 ````` 99
        */
        for(uint a=0; a<10; a++) {
            for(uint b=0; b<10; b++) {
                PW2 = keccak256(abi.encodePacked(uint(0), uint(4), a, b));
                if(PW == PW2) {
                    return (true, a, b); // 최종결과 -> PW와 PW2가 일치하는지 확인
                }
            }
        }
    }

    // true 확인 후, 비밀번호 확인
    function getPW() public view returns(bytes32) {
        return PW2;
    }
}