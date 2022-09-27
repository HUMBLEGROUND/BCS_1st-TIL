// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/* 여러분은 설문조사기관에 근무하고 있습니다. 
피자를 좋아하는 사람, 싫어하는 사람, 
햄버거를 좋아하는 사람, 싫어하는 사람의 숫자를 구해야합니다. 
각각의 음식을 좋아하는 사람과 싫어하는 사람의 숫자를 구하고 
기록하는 컨트랙트를 구현하세요. */

contract A {

    uint pizzaUp = 0;
    uint pizzaDown = 0;

    uint hamburgerUp = 0;
    uint hamburgerDown = 0;
    
    function PizzaLike () public returns (uint) {
        return pizzaUp++;
    }

    function PizzaUnLike () public returns (uint) {
        return pizzaDown++;
    }

    function HamburgerLike () public returns (uint) {
        return hamburgerUp++;
    }

    function HamburgerUnLike () public returns (uint) {
        return hamburgerDown++;
    }

    function Result () public view returns (uint, uint, uint, uint) {
        return (pizzaUp, pizzaDown, hamburgerUp, hamburgerDown);
    }

    }