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

// 매핑 대체 버전
contract B {
    struct vote {
        uint num;
        string title;
        string write;
        address wtiter;
        uint good;
        uint bad;
    }

    mapping(string => vote) votes; // 매핑으로 대체
    uint index;

    struct user {
        string userName; // 사용자 이름
        string[] voteList; // 만든 안건
        mapping(string => bool) voted; // 찬반투표
    }

    mapping(address => user) users;

    // 투표 생성
    function setVote(string memory _title, string memory _write) public {
        votes[_title] = vote(index++, _title, _write, msg.sender, 0,0);
        // users는 mapping으로 설정. 지갑주소를 key 값으로 넣으면 value값으로 user 구조체가 반환
        users[msg.sender].voteList.push(_title); // user 구조체 안에 poll_list에 추가하는 코드
    }

    // 투표 조회
    function getVote(string memory _title) public view returns(uint, string memory, string memory, address, uint, uint) {
        // 매핑으로 대체되어 _title로 바로 검색
		return (votes[_title].num, votes[_title].title, votes[_title].write, votes[_title].wtiter, votes[_title].good, votes[_title].bad);
    }

    // 유저 설정
    function setUser(string memory _name) public {
        users[msg.sender].userName = _name; 
        // users라는 매핑에 msg.sender를 key 값으로 주고 _name을 value값으로 설정
    }

    // 유저 조회, 정보 받아오기, 자기 지갑과 연결된 정보 받아오기
    function getUser() public view returns(string memory, uint) {
        // users 매핑에 msg.sender를 key 값으로 주고 name과 poll_list의 길이(poll_list.length)를 output값으로 설정
        return (users[msg.sender].userName, users[msg.sender].voteList.length);
    }

    // 유저가 한 투표 결과조회
    function getUser2(string memory _a) public view returns(bool) {
        return users[msg.sender].voted[_a];
    }

    // 투표하기
    function goVote(string memory _title, bool _b) public {
        // 입력한 _title과 각 요소의 title이 일치하는지 확인 (for 문은 이제 필요 없음)
        if(keccak256(bytes(votes[_title].title)) == keccak256(bytes(_title))) { //title과 _title 비교, string은 직접 비교가 아닌 hash값으로
            // 비교 후 통과하면 찬반여부 판단
            // 찬성이면 
            if(_b == true) {
                // Polls array의 i번 요소의 poll 구조체 내 agree에 숫자 1 추가
                votes[_title].good++;
                // user도 자신이 투표한 안건의 결과 데이터를 업데이트 해야함. users mapping을 address로 타고 들어가 user 구조체 내 voted mapping을 건드림.
                users[msg.sender].voted[_title] = true;  // voted는 string과 bool로 구성(key -value), _title을 key값으로 넣고 _b를 value 값으로 넣음.
            } else {
                votes[_title].bad++;
                users[msg.sender].voted[_title] = false;
            }
        } 
    
    }
}