// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "../interfaces/IEmissionCurve.sol";
import "openzeppelin-contracts/contracts/access/AccessControl.sol";

contract BeetsConstantEmissionCurve is IEmissionCurve, AccessControl {

    event LogRate(uint rate);

    /// @notice Access control roles.
    bytes32 public constant OPERATOR = keccak256("OPERATOR");

    uint256 public rewardPerSecond;

    constructor(uint256 _rewardPerSecond) {
        rewardPerSecond = _rewardPerSecond;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function getRate(uint256)
        external
        view
        override
        returns (uint256)
    {
        return rewardPerSecond;
    }

    function setRate(uint256 _rewardPerSecond) external onlyRole(OPERATOR) {
        rewardPerSecond = _rewardPerSecond;
        emit LogRate(_rewardPerSecond);
    }
}
