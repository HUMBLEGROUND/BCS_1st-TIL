// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 숫자와 주소와 잔고를 포함한 구조체, 
// 이 구조체들을 모아놓은 배열, 
// 그 배열에 정보를 넣는 함수, 
// n번째 사람의 주소와 잔액을 보여주는 함수

contract B {
    struct wallet {
        uint num;
        address walletAddress;
        uint balance;
    } // 구조체 

    wallet[] Wallets; // 빈배열 생성

    function pushWallet() public {
        Wallets.push(wallet(Wallets.length+1, msg.sender, msg.sender.balance));
        // 빈배열에 push (wallet 구조체를 적용)
        // Wallets.length+1 👉 배열에 항상 마지막추가 되는 
        // msg.sender 내 주소
        // msg.sender.balance 내 주소 잔고
    }
    // 👉 지갑을 바꿔가면서 push 트랜잭션을 일으킨다 👉 배열에 저장됨

    function getBalance(uint _n) public view returns(address, uint) {
        return (Wallets[_n-1].walletAddress, Wallets[_n-1].balance);
        // Wallets[_n-1] 👉 배열의 항상 마지막 요소
        // 배열의 마지막요소의 주소와 잔고 조회
    }
    // 👉 배열의 몇번째 (_n) 인지만 입력하면 조회가능

    function donate() public payable returns(uint) {
        return msg.value;
        // 이더 주는 함수 (payable)
    }

    // donate 함수로 해당컨트랙트에 이더를 1개 주면 
    // 잔고가 99 👉 98 로 줄었는데도 getBalance 조회하면 99가 나오고 갱신이 안되어있음
    // pushWallet 해야 이더 잔고가 98로 다시 찍힌다 👉 그래서 renew 작업

    function renewBalance(uint _n) public {
        // renew 함수 👉 지갑잔고를 바로 갱신해주는 함수
        delete Wallets[_n-1].balance; // 입력하는 배열의 마지막 잔고를 0으로 만들어줌
        Wallets[_n-1].balance = msg.sender.balance;
        // 배열의 마지막 잔고를 = 현재 지갑 잔고로 갱신
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
        // 별도의 과정을 거치지않고 해당 주소의 잔고를 바로 조회해준다
    }

// ⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
// 이더주고 + 지갑잔고 바로 갱신효과
    function donateRenew(uint _n) public payable {
        delete Wallets[_n-1].balance; // 입력하는 배열의 마지막 잔고를 0으로 만들어줌
        Wallets[_n-1].balance = msg.sender.balance;
        // 배열의 마지막 잔고를 = 현재 지갑 잔고로 갱신
    }
}