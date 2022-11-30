// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A {
    address payable owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    // 컨트랙트에 이더 넣기(보내기)(송금)
    function deposit() public payable {} 
    // 아무것도 없이 payable 만 있으면 컨트랙트에 넣는다는 의미

    // 컨트랙트에 이더 넣기(보내기)(송금)
    function deposit2() public payable returns(uint) {
        return msg.value;
    }

    // 컨트랙트에서 해당주소에게 이더 보내기(송금)
    function transferTo(address payable _to, uint _amount) public {
        _to.transfer(_amount);
        // transfer 는 payable이 자동 내장되어있다
        // ⭐ 이더를 받는 주소에는 payable 를 써야한다
    }

    // 이 컨트랙트 잔고 조회
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // 나의 지갑잔고 조회
    function getMyBalance() public view returns(uint) {
        return address(msg.sender).balance;
    }   
}