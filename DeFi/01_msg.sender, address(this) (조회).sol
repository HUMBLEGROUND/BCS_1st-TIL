// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract B {
    address b;

    function getAddress() public view returns(address) {
        return address(this);
        // 해당 컨트렉트 주소 출력 (배포된 이 컨트렉트 주소)
    }
    
    function myAddress() public view returns(address) {
        return address(msg.sender);
        // 내 주소 출력 (거래를 일으키는 사람)
    }

    function myBalance() public view returns(uint) {
        return address(msg.sender).balance;
        // 내 잔고 출력
    }

    function friendBalance(address _a) public view returns(uint) {
        return address(_a).balance;
        // 친구의 주소를 넣으면 잔고를 확인
    }
    
    function friendBalance2() public view returns(uint) {
        return address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db).balance;
        // 해당 주소의 잔고를 확인
    }

}