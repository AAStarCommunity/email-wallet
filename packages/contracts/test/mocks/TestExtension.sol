// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {Extension} from "../../src/interfaces/Extension.sol";
import "../../src/interfaces/Types.sol";

contract TextExtension is Extension {
    function execute(
        uint8 templateIndex,
        bytes[] memory subjectParams,
        address wallet,
        bool hasEmailRecipient,
        address recipientETHAddr,
        bytes32 emailNullifier
    ) external pure override {
        templateIndex;
        subjectParams;
        wallet;
        hasEmailRecipient;
        recipientETHAddr;
        emailNullifier;
    }

    function registerUnclaimedState(
        UnclaimedState memory unclaimedState,
        bool isInternal
    ) public pure override returns (bool) {
        unclaimedState;
        isInternal;

        return true;
    }

    function claimUnclaimedState(UnclaimedState memory unclaimedState, address wallet) external pure override {
        unclaimedState;
        wallet;
    }

    function voidUnclaimedState(UnclaimedState memory unclaimedState) external pure override {
        unclaimedState;
    }
}