pragma solidity ^0.8.0;

// contract was deployed at: 
// https://goerli.etherscan.io/address/0x210C84D8Ed24888C62970e7654CC9b49A3e7BdB3

contract BuyMeACoffee{

    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo{
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] memos;

    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }


    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value>0, "cant't buy coffee with 0 eth");
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        // Emit a log event when a new mmemo is created!
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    // send the entire balance in this contract to the owner
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns(Memo[] memory){
        return memos;
    }

}