// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
221124
간단한 게임이 있습니다.

유저는 번호, 이름, 주소, 잔고, 점수를 포함한 구조체입니다.
참가할 때 참가비용 1ETH를 내야합니다. (payable 함수)
4명까지만 들어올 수 있는 방이 있습니다. (array)
선착순 4명에게는 각각 4,3,2,1점의 점수를 부여하고 
4명이 되는 순간 방이 비워져야 합니다.

유저는 10점 단위로 점수를 0.05ETH만큼 변환시킬 수 있습니다.
관리자는 원할 때마다 돈을 뺄 수 있습니다. (관리자만 뺄 수 있어야 합니다.)

게임참가자 전체를 반환하는 함수 
그리고 특정 참가자를 반환하는 함수도 구현하세요(address로 검색)
위의 게임을 구현하세요.
*/

/*
1 - Alice (관리자)
2 - Bob
3 - Charlie
4 - Dwayne

1,2,3,4 // 1,2,3,4 // 1,2,3,4 -> 3라운드돌리고
각각의 점수 확인
getBalance로 contract 잔고 확인

Alice getMoney로 2 시도(오류 확인) // 1시도
1시도 후 점수 감소 확인, getBalance 감소 확인
withdraw로 인출해보기, getBalance 감소 확인
*/

contract Room {
    struct user {
        uint number;
        string name;
        address addr;
        uint balance;
        uint score;
        bool isInclude; // 게임 참가 여부
    }
    mapping(address => user) users;
    address[] room;

    // 관리자 주소
    address payable owner;
    // 관리자 최초 배포자로 설정
    constructor() payable {
        owner = payable(msg.sender);
    }

    uint index;

    // 유저 설정
    function setUser(string memory _name) public {
        users[msg.sender] = user(index++, _name, msg.sender, msg.sender.balance, 0, false);
    }

    // 유저 조회
    function getUser(address _a) public view returns(uint, string memory, address, uint, uint) {
        return(users[_a].number, users[_a].name, users[_a].addr, users[_a].balance, users[_a].score);
    }

    // 자동으로 1eth가 전송되게 실행해보기
    function enterRoom() public payable {
        require(msg.value==1000000000000000000 && users[msg.sender].isInclude == false);

        room.push(msg.sender); // room 에 들어가게 하기
        users[msg.sender].isInclude = true;
        
        if(room.length ==4) {
            for(uint i=4; i >0; i--) {
                users[room[i-1]].score += 5-i;
                // room에 들어오는 순서대로 점수 부여 / 5-1 5-2 5-3 5-4
                users[room[i-1]].isInclude = false;
                room.pop(); // 4명이 다 들어왔으면 비우기
            }
        }
    }

    // 관리자만 출금할 수 있는 출금 함수
    function withdraw(uint _amount) public {
        require(msg.sender == owner);
        owner.transfer(_amount);
        // 지갑.transfer(얼마)
    }

    // 사용자들 point 변환
    // 10점마다 0.05ETH (10점마다 5만큼)
    function getMoney(uint _a) public {
        uint a = users[msg.sender].score / 10; // 점수 계산
        require(a >= _a); // 가능한 금액과 요청한 금액 비교
        users[msg.sender].score -= _a * 10; // 점수 삭감
        payable(msg.sender).transfer(_a * 5 * 10000000000000000);// 지급
    }

    // 컨트랙트의 잔고 조회
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}