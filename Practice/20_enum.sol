// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.12;

contract enumExample {
    enum Grade {
        A, // 0 번째
        B, // 1 번째
        C  // 2 번째
    }

    Grade grade;

    function setA() public {
        grade = Grade.A; // 👉 0 출력
    }

    function setB() public {
        grade = Grade.B; // 👉 1 출력
    }

    function setC() public {
        grade = Grade.C; // 👉 2 출력
    }

    function getGrade() public view returns(Grade) {
        return grade; // 👉 해당 set 출력
    }
}

contract enumExample2 {
    enum Class {spades, diamonds, hearts, clovers}
    enum Value {Ace, two, three, four, five, six, seven, eight, nine, ten, J, Q, K}

    struct Card {
        Class class; // Class형 변수 class
        Value value; // Value형 변수 value
    }

    Card card; // Card형 변수 card 

    function setCard(Class _class, Value _value) public returns(Class, Value) {
        card.class = _class;
        card.value = _value;

        return (card.class, card.value);
    }

    function setCard2(Class _class, Value _value) public returns(Card memory) {
        card.class = _class;
        card.value = _value;

        return card;
    }
}

contract enumExample3 {
    enum Status {turnedOff, turnOn, Stop, Driving, outOfGas}
    Status status;

    constructor() {
        status = Status.turnedOff;
    }

    function Parking() public {
        status = Status.Driving; // 👉 3 출력
    }

    function drive() public {
        status = Status.Stop; // 👉 2 출력
    }

    function getStatus() public view returns(Status) {
        return status; // 👉 해당 set 출력
    }
}

contract enumExample4 {
    enum Class {spades, clovers, diamonds, hearts}
    enum Value {Ace, two, three, four, five, six, seven, eight, nine, ten, J, Q, K}

    struct Card {
        Class cls;
        Value vl;
    }

    Card card;

    function setCard(Class _cls, Value _vl) public {
        card.cls = _cls;
        card.vl = _vl;
    }

    function getCard() public view returns(Card memory) {
        return card;
    }
}