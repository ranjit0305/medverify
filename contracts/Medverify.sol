// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedVerify {
    struct Medicine {
        string name;
        uint256 batchId;
        address distributor;
        address retailer;
        bool isVerified;
    }

    mapping(uint256 => Medicine) public medicines;

    // Event to log new medicine batches
    event NewBatchCreated(
        uint256 batchId,
        string name,
        address distributor,
        address retailer
    );

    // Event to log verification status
    event BatchVerified(
        uint256 batchId,
        bool isVerified
    );

    // Create a new medicine batch
    function createBatch(
        uint256 _batchId,
        string memory _name,
        address _distributor,
        address _retailer
    ) public {
        require(medicines[_batchId].batchId == 0, "Batch already exists");
        
        medicines[_batchId] = Medicine({
            name: _name,
            batchId: _batchId,
            distributor: _distributor,
            retailer: _retailer,
            isVerified: false
        });

        emit NewBatchCreated(_batchId, _name, _distributor, _retailer);
    }

    // Verify a medicine batch by the distributor
    function verifyBatch(uint256 _batchId) public {
        require(medicines[_batchId].batchId != 0, "Batch does not exist");
        require(msg.sender == medicines[_batchId].distributor, "Only distributor can verify");

        medicines[_batchId].isVerified = true;

        emit BatchVerified(_batchId, true);
    }
    
    function getBatchDetails(uint256 _batchId)
        public
        view
        returns (string memory, uint256, address, address, bool)
    {
        Medicine memory medicine = medicines[_batchId];
        return (
            medicine.name,
            medicine.batchId,
            medicine.distributor,
            medicine.retailer,
            medicine.isVerified
        );
    }
}
