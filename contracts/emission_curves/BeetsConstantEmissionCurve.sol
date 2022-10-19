
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "../interfaces/IEmissionCurve.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract BeetsConstantEmissionCurve is IEmissionCurve, Ownable {
    uint public rate;

    constructor(uint _rate) {
        rate = _rate;
    }

    function getRate(uint lastRewardTime) external view override returns (uint) {
        return rate;
    }

    function setRate(uint _rate) external onlyOwner {
        rate = _rate;
    }
}
