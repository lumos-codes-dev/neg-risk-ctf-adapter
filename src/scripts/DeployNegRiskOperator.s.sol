// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {vm} from "../dev/libraries/Vm.sol";
import {NegRiskOperator} from "src/NegRiskOperator.sol";

contract DeployNegRiskOperator {
    function run(address _negRiskAdapter) external returns (address negRiskOperator) {
        vm.broadcast();
        negRiskOperator = address(new NegRiskOperator(_negRiskAdapter));
    }
}
