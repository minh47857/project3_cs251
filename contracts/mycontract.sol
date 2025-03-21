// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS

// ADD YOUR CONTRACT CODE BELOW
    mapping (address => mapping (address => uint32)) debts;
    address[] users;
    mapping(address => bool) isUser;

    function lookup(address _debtor, address _creditor) public view returns (uint32 ret) {
        return debts[_debtor][_creditor];
    }

    function add_IOU(address _creditor, uint32 _amount) public {
        require(_amount > 0, "amount is not positive");
        debts[msg.sender][_creditor] += _amount;

        addUser(msg.sender);
        addUser(_creditor);
    }

    function getUsers() public view returns (address[] memory) {
        return users;
    }

    function addUser(address _userAddress) internal {
        if(!isUser[_userAddress]) {
            users.push(_userAddress);
            isUser[_userAddress] = true;
        }
    }

    function getTotalOwed(address _debtor) public view returns (uint32) {
        uint32 totalOwed = 0;
        for(uint i = 0; i < users.length; i++) {
           totalOwed += debts[_debtor][users[i]]; 
        }
        return totalOwed;
    }

    function getNeighbors(address node) public view returns (address[] memory) {
        uint neighborsCount = 0;
        for(uint i = 0; i < users.length; i++) {
            if(debts[node][users[i]] > 0) {
                neighborsCount++;
            }
        }

        address[] memory neighbors = new address[](neighborsCount);
        
        uint index = 0;
        for(uint i = 0; i < users.length; i++) {
            if(debts[node][users[i]] > 0) {
                neighbors[index++] = users[i];
            }
        }

        return neighbors;
    }

    function resolvingLoops(address[] memory path) public {
        uint32 minDebts = debts[path[path.length - 1]][path[0]];
        for(uint i = 0; i < path.length - 1; i++) {
            if(debts[path[i]][path[i + 1]] < minDebts) {
                minDebts = debts[path[i]][path[i + 1]];
            }
        }

        debts[path[path.length - 1]][path[0]] -= minDebts;
        for(uint i = 0; i < path.length - 1; i++) {
            debts[path[i]][path[i + 1]] -= minDebts;
        }
    }

}
