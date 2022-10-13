pragma solidity ^0.8.13;

import "./IERC20.sol";

contract StakingReward {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardsToken;
    // 수정불가 변수

    address public owner;

    uint public duration; // 보상기간
    uint public finishAt; // 보상이 종료되는 시점 
    uint public updatedAt; // 마지막으로 업데이트된 시간 추적
    uint public rewardRate; // 초당 얻는 보상 
    uint public rewardPerTokenStored; // 보상 비율 토큰 저장소당 보상비율에 기간을 곱한 값 = 총 공급량으로 나눈값
    
    mapping(address => uint) public userRewardPerTokenPaid; // 사용자당 저장된 토큰에 대한 보상을 추적
    mapping(address => uint) public rewards; // 사용자가 얻은 보상을 추적

    // 스테이킹 토큰의 총 공급량과 사용자당 스테이크 금액을 추적하는 상태변수
    uint public totalSupply;
    mapping(address => uint) public balanceOf; // 사용자의 스테이킹 토큰을 추적

    modifier onlyOwner() { // 소유자인지 검증 👉 소유자만 호출할 수 있도록
        require(msg.sender == owner, "not owner"); // 검증끝내면
        _; // 함수 실행
    }

    modifier updateReward(address _account) {
        rewardPerTokenStored = rewardPerToken();
        updatedAt = lastTimeRewardApp();

        if (_account != address(0)) {
            rewards[_account] = earned(_account); // mapping 값
            userRewardPerTokenPaid[_account] = rewardPerTokenStored; // mapping 값
        }
        _;
    }

    constructor(address _stakingToken, address _rewardsToken) { // 다른 컨트랙트에서 쓰일 기본값설정
        owner = msg.sender;
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }
// 보상을 받는 동안 소유자가 기간을 변경못하게
    function setRewardsDuration (uint _duration) external onlyOwner { // 스테이킹시킬 기간 설정
        require(finishAt < block.timestamp, "reward duration not finished");
        // 보상이 종료되는 시점이 아직 현재 block.timestamp 보다 작을경우 실행
        // (보상기간이 만료되었거나 아예 시작되지 않았거나)
        duration = _duration; // 기간 입력
    }

    // modifier updateReward (address _account 의 값을 address(0)로 설정 👉 if 에 안걸리도록)
    function notifyRewardAmount (uint _amount) external onlyOwner updateReward(address(0)) { // 보상의 비율을 지정, 금액 알림
        if (finishAt < block.timestamp) { // 보상기간이 만료되었거나 아예 시작되지 않았거나
            rewardRate = _amount / duration; // 보상비율이 = 지급될 보상 금액을 👉 보상기간으로 나눈값
        } else { // 아직 스테이킹 중 일경우 (보상을 받고있는중)
            uint remainRewards = rewardRate * (finishAt - block.timestamp); 
            // 초당 얻는 보상  * (아직 진행중인 block.timestamp - block.timestamp) 
            rewardRate = (remainRewards + _amount) / duration;
            // 초당 얻는 보상 = 계산값 + 보상 양 / 보상 기간          
        }
        require(rewardRate > 0, "reward rate = 0"); // 받을 보상이 0보다 클 경우 실행
        require(rewardRate * duration <= rewardsToken.balanceOf(address(this)), "reward amount > balance");
        // 받을 보상 * 보상 기간이 작거나 같으면 실행
        finishAt = block.timestamp + duration;
        updatedAt = block.timestamp;
    }

    // modifier updateReward (address _account 의 값을 msg.sender로 설정)
    function stake (uint _amount) external updateReward(msg.sender) { // 스테이킹 할 양 설정
        require(_amount > 0, "amount = 0");
        stakingToken.transferFrom(msg.sender, address(this), _amount);
        // 소유자가 👉 이 주소에 👉 스테이킹 할 양을 설정해서 👉 전송
        // address(this) 👉 해당 컨트렉트 주소 출력 (배포된 이 컨트렉트 주소)
        balanceOf[msg.sender] += _amount;
        // 소유자 주소 잔고에 👉 스테이킹 할 양을 더함
        totalSupply += _amount;
    }

    // modifier updateReward (address _account 의 값을 msg.sender로 설정)
    function withdraw (uint _amount) external updateReward(msg.sender) { // 스테이킹 철회 출금요청
        require(_amount > 0, "amount = 0");
        balanceOf[msg.sender] -= _amount;
        // 소유자 주소 잔고에 👉 _amount 값 빼기
        totalSupply -= _amount;
        stakingToken.transfer(msg.sender, _amount);
    }

    function lastTimeRewardApp () public view returns (uint) { // 마지막시간 보상적용가능
        return _min(block.timestamp, finishAt); // 보상이 아직 남아있을때 타임스탬프를 retrun
    }

    function _min (uint x, uint y) private pure returns (uint) { // lastTimeRewardApp에서 쓰일 private 함수
        return x <= y ? x : y; // 3항 연산자
    }

    function rewardPerToken () public view returns (uint) { // 토큰당 보상
        if (totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored + (rewardRate * (lastTimeRewardApp() - updatedAt) * 1e18) / totalSupply;
        // lastTimeRewardApp 함수 불러와서 계산
    }

    function earned (address _account) public view returns (uint) { // 계좌를 입력하면 얻은 보상을 보여준다
        return (balanceOf[_account] * (rewardPerToken() - userRewardPerTokenPaid[_account])) / 1e18 + rewards[_account];
        // 입력한 주소의 잔고 * 토큰당 보상 함수 - mapping 값 + mapping 값
    }
    function getReward () external updateReward(msg.sender) { // 이 함수를 호출하면 보상을 얻음
        uint reward = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, reward);
        }
    }
}