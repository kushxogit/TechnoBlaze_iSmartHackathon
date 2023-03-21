// SPDX-License-Identifier: MIT

pragma solidity ^0.4.18;
contract inventorydemo {
    address public owner;

    uint public Inventory;
    uint private ConfirmNumber;
    
     mapping(address => product_id) private products; // product_id    products
     
   modifier onlyOwner {
        require (msg.sender == owner);
        _;
    }

    struct product_id { //product_id
      uint ConfirmationNumber;
      product_details product_detail; //product_details product_detail
    }
    
    struct product_details{  //product_details
        string Name;
        uint productCount;  //productCount
    }
    
    function inventorydemo() {  //inventory
        owner = msg.sender;
        ConfirmNumber = 0;
    }

    function sendProduct(uint _cargoCount,string _productName,uint _productCount){  //send a product. _cargoCount, _productName, _productCount
        if(Inventory>=_cargoCount) //_cargoCount
        {
        Inventory =Inventory - _cargoCount; //_cargoCount
        ConfirmNumber ++;
        products[msg.sender].ConfirmationNumber = ConfirmNumber;  
        products[msg.sender].product_detail.Name = _productName;// product_details
        products[msg.sender].product_detail.productCount = _productCount;  //productCount,  _productCount
        }
    }
    
    function GetBookingDetails() constant returns (uint GuestConfirmationNumber,string GuestName, uint GuestCount)
    {
        return (products[msg.sender].ConfirmationNumber,products[msg.sender].product_detail.Name,products[msg.sender].product_detail.productCount); // products = guests, product_detail, productCount
    }
    
    function ModifyInventory(uint _inventory) onlyOwner { 
        Inventory = _inventory;
    }
    
    function GetBookingByAddress(address _address) onlyOwner constant returns (uint GuestConfirmationNumber,string GuestName, uint GuestCount)
    {
        return (products[_address].ConfirmationNumber,products[_address].product_detail.Name,products[_address].product_detail.productCount);//products, product_details, productCount
    }
}
