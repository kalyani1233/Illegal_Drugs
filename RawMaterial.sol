// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;
import "./Admin.sol";

contract Supplier{
      address admin;
      constructor(address _admin)public{
          admin=_admin;
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
    mapping(address =>address[]) supplierRawProductInfo;
    event RawSupplyInit(
        address indexed productId,
        address indexed supplier,
        address shipper,
        address indexed receiver
    );

    function createRawpackage(
        string memory _desciption,
        string memory _ownerName,
        string  memory _location,
        uint256 _quantity,
        address _shipperr,
        address _manufacturer
    )public{
     require(roles(Admin(admin).getRole(msg.sender))==roles.supplier,"Only supplier can create a package!");
     RawMaterial rawData = new RawMaterial(
         msg.sender,
         _description,
         _ownerName,
         _location,
         _quantity,
         _shipperr,
         _manufacturer

     );
     supplierRawProductInfo[msg.sender].push(address(rawData))
    }
}