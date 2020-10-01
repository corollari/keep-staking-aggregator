pragma solidity 0.5.17;

interface ITokenStaking {
    /// @notice Undelegates staked tokens. You will be able to recover your stake by calling
    /// `recoverStake()` with operator address once undelegation period is over.
    /// @param _operator Address of the stake operator.
    function undelegate(address _operator) external;

    /// @notice Recovers staked tokens and transfers them back to the owner.
    /// Recovering tokens can only be performed when the operator finished
    /// undelegating.
    /// @param _operator Operator address.
    function recoverStake(address _operator) external;
}
