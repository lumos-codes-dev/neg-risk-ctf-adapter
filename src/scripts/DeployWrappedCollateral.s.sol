// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {vm} from "../dev/libraries/Vm.sol";
import {WrappedCollateral} from "src/WrappedCollateral.sol";

contract DeployWrappedCollateral {
    function run(address _underlying, uint8 _decimals) external returns (address wrappedCollateral) {
        vm.broadcast();
        wrappedCollateral = address(new WrappedCollateral(_underlying, _decimals));
    }
}
