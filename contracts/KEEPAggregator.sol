// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "@gnosis.pm/safe-contracts/contracts/GnosisSafe.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ITokenStaking.sol";

contract KEEPAggregator is ERC20, ERC20Detailed, GnosisSafe {
	IERC20 keepToken = IERC20(0x85Eee30c52B0b379b046Fb0F85F4f3Dc3009aFEC);
	ITokenStaking tokenStaking = ITokenStaking(0x6D1140a8c8e6Fac242652F0a5A8171b898c67600);
	bool pausedWithdraws = false;

	constructor(address[] memory _owners) ERC20Detailed("Staking KEEP", "stKEEP", 18) public {
		threshold = 0;
        setup(_owners, _owners.length, address(0), bytes(""), address(0), address(0), 0, address(0));
    }

	function deposit(uint amount) public {
		keepToken.transferFrom(msg.sender, address(this), amount);
		_mint(msg.sender, amount);
	}

	function withdraw(uint amount) public {
		_burn(msg.sender, amount);
		keepToken.transfer(msg.sender, amount);
	}

	function setPauseWithdraws(bool newValue) public {
		require(msg.sender == address(this));
		pausedWithdraws = newValue;
	}

	function undelegate(address operator) public {
		require(owners[msg.sender] != address(0), "Only owners can undelegate keep");
		tokenStaking.undelegate(operator);
	}

	function recoverStake(address operator) public {
		require(owners[msg.sender] != address(0), "Only owners can unstake keep");
		tokenStaking.recoverStake(operator);
	}
}
