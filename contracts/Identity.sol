//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Identity {
    // User struct

    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can call this function");
        _;
    }

    constructor() {
        manager = msg.sender;
    }

    struct User {
        address userAddress;
        string name;
        string governmentId;
        bytes32 hash;
    }

    // mapping of users
    mapping (address => User) public users;

    // events
    event IdentityAdded(address indexed userAddress, string name, string governmentId);
    event IdentityUpdated(address indexed userAddress, string name, string governmentId);
    event IdentityVerified(address indexed userAddress);

    // address of the manager
    address public manager;

    // function to set the manager
    function setManager(address _manager) public onlyManager {
        manager = _manager;
    }

    // function to add new user
        // function to add new user
    function addIdentity(address _userAddress, string memory _name, string memory _governmentId) public onlyManager {
        require(users[_userAddress].hash == bytes32(0), "Identity already exists.");
        bytes32 hash = keccak256(abi.encodePacked(_userAddress, _name, _governmentId));
        users[_userAddress] = User(_userAddress, _name, _governmentId, hash);
        emit IdentityAdded(_userAddress, _name, _governmentId);
    }

    // function to update user's identity
    function updateIdentity(address _userAddress, string memory _name, string memory _governmentId) public onlyManager {
        require(users[_userAddress].hash != bytes32(0), "Identity does not exist.");
        bytes32 hash = keccak256(abi.encodePacked(_userAddress, _name, _governmentId));
        users[_userAddress] = User(_userAddress, _name, _governmentId, hash);
        emit IdentityUpdated(_userAddress, _name, _governmentId);
    }

    // function to verify user's identity
    function verifyIdentity(address _userAddress, bytes32 _hash) public returns (bool) {
        emit IdentityVerified(_userAddress);
        return users[_userAddress].hash == _hash;
    }
}
