contract C {
    bytes32 pw = 0x3ac225168df54212a25c1c01fd35bebfea408fdac2e31ddd6f80a4bbf9a5f1cb; //a를 해쉬화
    uint a;

    function getHash(string memory _a) public returns(bytes32) {
        return keccak256(bytes(_a));
    }

    function setNumber(string memory _pw, uint _a) public returns(uint) {
        require(pw == getHash(_pw)); // 비밀번호 검증
        a = _a; // 비밀번호가 검증되면 a값을 바꾸게 해준다
        return a;
    }
}