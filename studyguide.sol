// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudyGuideIncentives {
    struct StudyGuide {
        string title;
        string contentHash; // IPFS hash for the content
        address creator; 
        uint256 reward;
    }

    StudyGuide[] public studyGuides;
    mapping(address => uint256) public rewards;

    event StudyGuideUploaded(uint256 id, string title, address indexed creator);
    event RewardClaimed(address indexed creator, uint256 amount);

    function uploadStudyGuide(string memory _title, string memory _contentHash) public {
        uint256 reward = 1 ether; // Reward for creating a study guide
        studyGuides.push(StudyGuide(_title, _contentHash, msg.sender, reward));
        rewards[msg.sender] += reward;
        emit StudyGuideUploaded(studyGuides.length - 1, _title, msg.sender);
    }

    function claimReward() public {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No rewards to claim");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
        emit RewardClaimed(msg.sender, reward);
    }

    // Function to deposit funds to the contract
    function depositFunds() public payable {}

    // Function to check the balance of the contract
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
