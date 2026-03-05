// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {vm} from "../dev/libraries/Vm.sol";
import {Vault} from "src/Vault.sol";

contract DeployVault {
    function run() external returns (address vault) {
        vm.broadcast();
        vault = address(new Vault());
    }
}
