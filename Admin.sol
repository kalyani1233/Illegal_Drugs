pragma solidity 0.8.13;
// SPDX-License-Identifier: MIT

contract Admin{
    address public owner;

    constructor() public{
        owner=msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner,"Sorry! Only Owner is allowed to visis!");
        _;
    }

    enum roles{
        norole,
        supplier,
        transporter,
        manufacturer,
        distributor,
        retailer,
        revoke

    }

    // Events occur in our program 
    event UserRegister(address indexed EthAddress,string  name);
    event UserRoleRevoked(address indexed EthAddress,string  name,uint Role);
    event UserRoleReassign(address indexed EthAddress,string  name,uint Role);
    
    struct UserInfo{
        string name;
        string location;
        address ethAddress;
        roles role;

    }
    mapping(address =>UserInfo) public UsersDetails;
    address[] users;

// function to register a user 
    function registerUser(
        address EthAddress,
        string memory name,
        string memory location,
        uint Role
    )public onlyOwner{
        require(UsersDetails[EthAddress].role==roles.norole,"User Already Registered!");
        UsersDetails[EthAddress].name=name;
        UsersDetails[EthAddress].location=location;
        UsersDetails[EthAddress].ethAddress=EthAddress;
        UsersDetails[EthAddress].role =roles(Role);
        users.push(EthAddress);
        emit UserRegister(EthAddress,name);
    }

// function to revoke role from user

function revokeRole(address userAddress)
         public onlyOwner{
             require(UsersDetails[EthAddress].role!=roles.norole,"User not registered!");
             emit UserRoleRevoked(userAddress,UsersDetails[userAddress].name,uint(UsersDetails[userAddress].role));
             UsersDetails[userAddress].role=roles(6);
         }

// function to reassign role 
function reassignRole(address userAddress,uint Role)
    public onlyOwner{
        require(UsersDetails[userAddress].role!=roles.norole,"user not registered!");
        UsersDetails[userAddress].role =roles(Role);
        emit UserRoleReassign(userAddress,UsersDetails[userAddress].name,uint(UsersDetails[userAddress].role));
    }


// function to get User Section
function getUserInfo(address userAddress) public view returns(string memory,string memory,address,uint){
    return(
    UsersDetails[userAddress].name,
    UsersDetails[userAddress].location,
    UsersDetails[userAddress].ethAddress,
    uint(UsersDetails[userAddress].role)
    );
}

// function to get User Count
function getUsersCount() public view returns(uint count){
    return users.lenght;
}
// function getUserByIndex
function getUserByIndex(uint index) public view returns(
    string memory,string memory,address,uint){
     return getUserInfo(users[index]);
}

// function to get Role of user by address

function getRole(address _address)public view returns(uint){
    return uint(UsersDetails[_address].role);
}

}