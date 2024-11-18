// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MedVerify is Ownable {
    struct Medicine {
        string name;
        uint256 batchId;
        address distributor;
        address retailer;
        bool isVerified;
        uint256 creationTime;
    }

    mapping(uint256 => Medicine) public medicines;
    mapping(address => bool) public authorizedVerifiers;

    event NewBatchCreated(
        uint256 batchId,
        string name,
        address distributor,
        address retailer
    );

    event BatchVerified(uint256 batchId, bool isVerified);

    modifier onlyAuthorizedVerifier() {
        require(authorizedVerifiers[msg.sender], "Not authorized to verify");
        _;
    }

    function createBatch(
        uint256 _batchId,
        string memory _name,
        address _distributor,
        address _retailer
    ) public onlyOwner {
        require(medicines[_batchId].batchId == 0, "Batch already exists");

        medicines[_batchId] = Medicine({
            name: _name,
            batchId: _batchId,
            distributor: _distributor,
            retailer: _retailer,
            isVerified: false,
            creationTime: block.timestamp
        });

        emit NewBatchCreated(_batchId, _name, _distributor, _retailer);
    }

    function verifyBatch(uint256 _batchId) public onlyAuthorizedVerifier {
        require(medicines[_batchId].batchId != 0, "Batch does not exist");
        require(msg.sender == medicines[_batchId].distributor, "Only distributor can verify");

        medicines[_batchId].isVerified = true;

        emit BatchVerified(_batchId, true);
    }

    function getBatchDetails(uint256 _batchId)
        public
        view
        returns (string memory, uint256, address, address, bool, uint256)
    {
        Medicine memory medicine = medicines[_batchId];
        return (
            medicine.name,
            medicine.batchId,
            medicine.distributor,
            medicine.retailer,
            medicine.isVerified,
            medicine.creationTime
        );
    }

    function addVerifier(address verifier) public onlyOwner {
        authorizedVerifiers[verifier] = true;
    }

    function updateRetailer(uint256 _batchId, address _newRetailer) public onlyOwner {
        require(medicines[_batchId].batchId != 0, "Batch does not exist");
        medicines[_batchId].retailer = _newRetailer;
    }
}
