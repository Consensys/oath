pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Oath {
    
    //2**14
    uint256 DEPOSITS_FOR_CHAIN_START = 16384;
    uint256 DEPOSIT_SIZE = 32;
    //10**9
    uint256 GWEI_PER_ETH = 1000000000;
    uint256 POW_CONTRACT_MERKLE_TREE_DEPTH = 32;
    uint256 SECONDS_PER_DAY = 86400;

    event HashChainValue(bytes32 previousReceiptRoot, bytes[2064] data, uint256 totalDepositCount);
    event ChainStart(bytes32 receiptRoot, bytes[8] time);

    //bytes32[]
    uint256 totalDepositCount;

    constructor() public {

    }

    function deposit(bytes[2048] memory depositParams) public payable {
        require(msg.value >= DEPOSIT_SIZE, "Deposit too low: msg.value < DEPOSIT_SIZE");

        uint256 memory index = totalDepositCount + 2**POW_CONTRACT_MERKLE_TREE_DEPTH;
        bytes[8] msgGwei;
        bytes[8] timestamp;
        bytes[2064] depositData;
        
    }
}