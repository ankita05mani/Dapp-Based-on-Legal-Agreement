// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GenericContract {

    struct Contract {
        address party1;
        address party2;
        string terms;
        bool isExecuted;
        uint256 amount;
    }
    
    Contract[] public contracts;
    
    event ContractCreated(uint256 contractId, address party1, address party2, string terms, uint256 amount);
    event ContractExecuted(uint256 contractId, address executor);
    
    function createContract(address _party2, string memory _terms, uint256 _amount) public returns (uint256) {
        require(_party2 != address(0), "Invalid party address");
        
        Contract memory newContract = Contract({
            party1: msg.sender,
            party2: _party2,
            terms: _terms,
            isExecuted: false,
            amount: _amount
        });
        
        contracts.push(newContract);
        uint256 contractId = contracts.length - 1;
        
        emit ContractCreated(contractId, msg.sender, _party2, _terms, _amount);
        return contractId;
    }
    
    function executeContract(uint256 contractId) public {
        require(contractId < contracts.length, "Invalid contract ID");
        require(!contracts[contractId].isExecuted, "Contract already executed");
        require(msg.sender == contracts[contractId].party1 || msg.sender == contracts[contractId].party2, "Not authorized to execute contract");
        
        contracts[contractId].isExecuted = true;
        payable(msg.sender).transfer(contracts[contractId].amount);
        
        emit ContractExecuted(contractId, msg.sender);
    }
    
    function getContract(uint256 contractId) public view returns (address, address, string memory, bool, uint256) {
        require(contractId < contracts.length, "Invalid contract ID");
        
        Contract memory c = contracts[contractId];
        return (c.party1, c.party2, c.terms, c.isExecuted, c.amount);
    }
}
