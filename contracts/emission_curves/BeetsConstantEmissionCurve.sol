
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "../interfaces/IEmissionCurve.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract BeetsConstantEmissionCurve is IEmissionCurve, Ownable {

    event EmissionUpdate(
        uint rewardsPerSecond
    );

    uint public rewardPerSecond;

    constructor(uint _rewardPerSecond) {
        rewardPerSecond = _rewardPerSecond;
    }

    function getRate(uint lastRewardTime) external view override returns (uint) {
        return rewardPerSecond;
    }

    function setRate(uint _rewardPerSecond) external onlyOwner {
        rewardPerSecond = _rewardPerSecond;
        emit EmissionUpdate(_rewardPerSecond);
    }
}
