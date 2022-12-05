// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract enumExample4 {
    enum Status {available, lended, recovery, missed} // 상태 열거형
    // 빌리기 가능, 대여중, 

    struct Book {
        uint number;
        string title; // 책 제목
        address lender; // 책 빌린사람
        address[] waitlist; // 예약 대기자
        Status status; // 책의 상태 (현황)
    }

    mapping(string => Book) Books;

    struct User {
        string name; // 유저 이름
        address addr; // 유저 주소
        uint amount; // 빌린 책 권수
        uint miss_count; // 잃어버린 책 권수
    }

    mapping(address => User) Users;
    uint index = 1;

    // 책 빌리기
    function lendBook(string memory _title) public {
        require(Users[msg.sender].miss_count <= 3 && Books[_title].status == Status.available);
        // 3번 이하로 잃어버린 사람일경우(신뢰) , 책을 빌리려면 상태는 == 가능한 상태
        Books[_title].status = Status.lended;
        // 그러면 빌릴수 있다
        Books[_title].lender = msg.sender;
        Users[msg.sender].amount++;
    }

    // 책 반납되면 최우선 예약자에게 자동으로 대출
    function autoLending(string memory _title) public {
        require(Books[_title].status == Status.available);
        if(Books[_title].waitlist.length > 0){
            Books[_title].lender = Books[_title].waitlist[0]; // 최우선 예약자
            Users[Books[_title].waitlist[0]].amount++; // 최우선 예약자의 빌린수 증가

            for(uint i=0; i < 2; i++){
                Books[_title].waitlist[i] = Books[_title].waitlist[i+1];
                // 예약자 
            }
            Books[_title].waitlist.pop(); 
        }
    }

    // 책 반납하기
    function returnBook(string memory _title) public {
        require(msg.sender == Books[_title].lender);
        Books[_title].status = Status.available;
        // 책을 반납했으니 == 가능하도록 상태변경
        Books[_title].lender = address(0);
        // 책을 빌린사람 초기화 시켜주기
        Users[msg.sender].amount--;
        autoLending(_title);
    }

    // 책 상태 조회
    function getBook(string memory _title) public view returns(uint, string memory, address, address[] memory, Status) {
        return (Books[_title].number, Books[_title].title, Books[_title].lender, Books[_title].waitlist, Books[_title].status);
    }

    // 책 정보 넣기
    function setBook(string memory _title) public {
        Books[_title] = Book(index++, _title, address(0), new address[](0), Status.available);
        // 아무도 빌린사람이 없어서 default 값인 address(0)
    }

    // 유저 정보 조회
    function getUser(address _addr) public view returns(User memory){
        return Users[_addr];
    }

    // 유저 정보 등록
    function setUser(string memory _name) public {
        Users[msg.sender] = User(_name, msg.sender, 0, 0);
    }

    // 책 분실신고
    function reportMissing(string memory _title) public {
        require(Books[_title].lender == msg.sender);
        // 책을 빌린사람이 == 일치한다면
        Books[_title].status = Status.missed;
        Users[msg.sender].miss_count++;
    }

    // 책 예약하기
    function reserveBook(string memory _title) public {
        require(Books[_title].status == Status.lended && Books[_title].waitlist.length < 3); 
        // 책을 빌려간 상태일경우 & 예약자가 3명 미만일경우
        Books[_title].waitlist.push(msg.sender);
        // waitlist 배열에 msg.sender 추가
    }
} 