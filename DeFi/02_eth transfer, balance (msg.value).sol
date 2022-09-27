// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract P {
    // payable함수는 함수 중 유일하게 코인을 전송할 수 있는 함수

    function send() public payable returns(uint) {
        uint a = msg.value;
        return a;
        // 배포된 해당 컨트랙트에게 이더 보내기 (배포된 이 컨트렉트 주소)
    } 

    function getBalance() public view returns(uint) {
        return address(this).balance;
        // 배포된 컨트랙트의 잔고 조회
    }

    function myBalance() public view returns(uint) {
        return address(msg.sender).balance;
        // 내 잔고 출력
    }
}