// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title AccessControl
 * @dev A role-based access control contract for restricting access to certain functions or features.
 */
contract AccessControl {
    
    // Struct to hold role information
    struct Role {
        bool exists;
        mapping(address => bool) members;
    }
    
    // Mapping of roles to their details
    mapping(bytes32 => Role) private roles;
    
    // Events for role creation and role assignment
    event RoleCreated(bytes32 role);
    event RoleAssigned(bytes32 role, address member);
    
    /**
     * @dev Creates a new role.
     * @param role The name of the role to be created.
     */
    function createRole(bytes32 role) external {
        require(!roles[role].exists, "Role already exists");
        roles[role] = Role(true);
        emit RoleCreated(role);
    }
    
    /**
     * @dev Assigns a role to a member.
     * @param role The name of the role to assign.
     * @param member The address of the member to assign the role to.
     */
    function assignRole(bytes32 role, address member) external {
        require(roles[role].exists, "Role does not exist");
        require(!roles[role].members[member], "Member already has role");
        roles[role].members[member] = true;
        emit RoleAssigned(role, member);
    }
    
    /**
     * @dev Checks whether a member has a role.
     * @param role The name of the role to check.
     * @param member The address of the member to check.
     * @return A boolean indicating whether the member has the role.
     */
    function hasRole(bytes32 role, address member) external view returns (bool) {
        return roles[role].members[member];
    }
    
    /**
     * @dev Removes a role from a member.
     * @param role The name of the role to remove.
     * @param member The address of the member to remove the role from.
     */
    function removeRole(bytes32 role, address member) external {
        require(roles[role].exists, "Role does not exist");
        require(roles[role].members[member], "Member does not have role");
        roles[role].members[member] = false;
    }
}
