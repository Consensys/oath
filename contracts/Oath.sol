pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Oath {
    
    //2**14
    uint256 DEPOSITS_FOR_CHAIN_START = 16384;
    uint256 DEPOSIT_SIZE = 32;
    uint256 MIN_TOPUP_SIZE = 1;
    //10**9
    uint256 GWEI_PER_ETH = 1000000000;
    uint256 POW_CONTRACT_MERKLE_TREE_DEPTH = 32;
    uint256 SECONDS_PER_DAY = 86400;

    event HashChainValue(bytes32 previousReceiptRoot, bytes[2064] data, uint256 totalDepositCount);
    event ChainStart(bytes32 receiptRoot, bytes[8] time);

    bytes32[uint256] receiptTree;
    uint256 totalDepositCount;

    constructor() public {

    }

    function deposit(bytes[2048] memory depositParams) public payable {
        require(msg.value >= DEPOSIT_SIZE, "Deposit too low: msg.value < DEPOSIT_SIZE");
        treeInsert(depositParams);
        totalDepositCount++;

        if(totalDepositCount == DEPOSITS_FOR_CHAIN_START){
            
        }
    }

    function topUp(bytes[2048] memory depositParams) public payable {
        require(msg.value >= MIN_TOPUP_SIZE, "Topup amount too low: msg.value < MIN_TOPUP_SIZE");
        treeInsert(depositParams);
    }

    function treeInsert(bytes[2048] memory depositParams) private payable returns (bool) {
        uint256 memory index = totalDepositCount + 2**POW_CONTRACT_MERKLE_TREE_DEPTH;
        bytes[8] memory msgGwei;
        bytes[8] memory timestamp;
        bytes[2064] memory depositData;

        emit HashChainValue(receiptTree[1], depositData, timestamp);

        receptTree[index] = sha3(depositData);

        for(uint i = 0; i < POW_CONTRACT_MERKLE_TREE_DEPTH; i++) {
            index /= 2;
            receiptTree[index] = sha3(receiptTree[index * 2], receiptTree[index * 2 + 1]);
        }
    }

    function getReceiptRoot() public view returns (bytes32) {
        return receiptTree[1];
    }
}