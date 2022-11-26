// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
221123
안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요. 
안건은 번호, 제목, 내용, 제안자 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
안건들을 모아놓은 array도 같이 구현하세요. 

각 안건의 현재상황(찬,반 투표수)을 알려주는 함수를 구현하세요.
사용자는 자신의 이름과 자신이 만든 안건 그리고 자신이 투표한 안건과 
어떻게 투표했는지(찬/반)에 대한 정보로 이루어져 있습니다.(구조체)
투표는 누구나 할 수 있습니다. 
투표하는 사람은 제목으로 검색하고 투표를 할 수 있습니다. 
제목과 의사표현을 입력값으로 구현하세요.

아래는 추가문제입니다. 
위의 기본문제를 모두 해결한 후에 시간이 남는다면 구현해주세요.

+1) 한번 투표한 안건에는 중복으로 투표할 수 없도록 하세요. 
(기존의 자료구조를 변경시켜도 됩니다.)

+2) 안건의 투표자가 10명 이상이며 찬성 비율이 70% 이상이면 
안건이 통과되도록, 이하면 기각되도록 구현하세요. 
(추가 배열 등을 구현하셔도 됩니다.)
*/

/*
실습과정
1 - user 등록 : A,B,C
2 - A 지갑으로 aa,bb,cc poll 등록
3 - B 지갑으로 각각 찬,반,찬 투표
4 - C 지갑으로 각각 찬,찬,찬 투표
5 - B,C 지갑으로 각각 getUser1,2 해보기
*/

contract A {
    struct vote {
        uint num;
        string title;
        string write;
        address wtiter;
        uint good;
        uint bad;
    }

    vote[] votes;

    struct user {
        string userName; // 사용자 이름
        string[] voteList; // 만든 안건
        mapping(string => bool) voted; // 찬반투표
    }

    mapping(address => user) users;

    // 투표 생성
    function setVote(string memory _title, string memory _write) public {
        votes.push(vote(votes.length+1, _title, _write, msg.sender, 0, 0));
        users[msg.sender].voteList.push(_title); // 안건 push
    }

    // 투표 조회
    function getVote(uint _a) public view returns (uint, string memory, string memory, address, uint, uint) {
        return (votes[_a-1].num, votes[_a-1].title, votes[_a-1].write, votes[_a-1].wtiter, votes[_a-1].good, votes[_a-1].bad);
        // 배열은 0이 기본값이기 때문에 / 입력값-1 을 해줘야 원하는 배열의 순서를 리턴해준다
    }

    // vote 전체 조회
    function getVoteAll() public view returns(vote[] memory) {
        return votes;
    }

    // 유저 설정
    function setUser(string memory _name) public {
        users[msg.sender].userName = _name;
    }

    // 유저 조회
    function getUser() public view returns(string memory, uint) {
        return (users[msg.sender].userName, users[msg.sender].voteList.length);
    }

    // 유저의 투표내용 조회
    function getUserVote(string memory _a) public view returns(bool) {
        return users[msg.sender].voted[_a];
    }

    // 투표하기
    function goVote(string memory _title, bool _b) public {
        for(uint i; i < votes.length; i++) {
            if(keccak256(bytes(votes[i].title)) == keccak256(bytes(_title))) {
                // 입력한 title과 / 안건에 등록된 title 이 같을경우
                if(_b == true) { // true (찬성) 일경우
                    votes[i].good++; // good 증가
                    users[msg.sender].voted[_title] = true; 
                    // mapping을 통해 증가
                } else {
                    votes[i].bad++; // bad 증가
                    users[msg.sender].voted[_title] = false;
                    // mapping을 통해 감소
                }
            }
        }
    }
}