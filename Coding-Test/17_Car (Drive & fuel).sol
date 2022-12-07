// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

    /*
    221129
    자동차의 상태(enum 변수)는 
    turnedOff, turnOn, Stop, Driving, outOfGas로 구성되어 있습니다.
    자동차는 이름, 연료량(uint) 그리고 상태로 구성되어 있는 구조체입니다.

    시작할 때 자동차의 이름은 input으로 받고 상태는 
    tunredOff를 기본으로 한다.(constructor)

    차 정보 받아오기 기능을 구현하세요. 
    차 시동을 거는 기능, 정지하는 기능을 구현하세요. 

    차를 운전하는 기능을 구현하세요. 운전을 하면 연료가 1만큼 감소합니다.
    연료가 일정 수준이하(3)로 떨어지게 되면 운전을 할 수 없습니다.

    연료를 충전하는 기능을 구현하세요. 최소 1이더를 넣어야 합니다. 
    (나머지는 버림해도 좋습니다)
    연료는 1이더당 10만큼 충전됩니다.
    */

contract enumCar {

    enum Status{turnedOff, turnOn, Stop, Driving, outOfGas} // 차 상태 열거형
    
    struct Car {
        string name;
        uint fuel;
        Status status;
    }

    Car car; // struct Car를 변수로

    // 초기조건 설정
    constructor(string memory _name) {
        car.name = _name;
        car.status = Status.turnedOff;
    }

    // 차 조회 기능
    function getCar() public view returns(Car memory) {
        return car;
    }

    // 차 정차 기능
    function stopCar() public {
        require(car.status == Status.Driving); // 운전중일때만 실행가능
        car.status = Status.Stop;
    }

    // 차 시동 기능
    function turnOn() public {
        require(car.status == Status.turnedOff); // 시동 정지상태일때만 가능
        car.status = Status.turnOn;
    }

    // 차 시동 끄기
    function turnOff() public {
        require(car.status == Status.turnOn || car.status == Status.Stop); 
        // 시동이 걸려있거나 / 정차했을때 가능
        car.status = Status.turnedOff;
    }

    // 연료 충전 기능
    function fillFuel() public payable {
        require(msg.value >= 10**18); // 최소 1이더를 넣어야 한다
        uint i = msg.value/10**18;
        car.fuel += i*10;
    }

    // 운전기능
    function driving() public {
        require(car.status == Status.turnOn && car.fuel > 3); 
        // 시동이 걸린상태이고 / 연료가 3 이하면 운전 불가
        car.status = Status.Driving;
        car.fuel--; // 연료 1씩 감소
    }
}