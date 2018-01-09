/*
This Token Contract implements the standard token functionality (https://github.com/ethereum/EIPs/issues/20) as well as the following OPTIONAL extras intended for use by humans.

In other words. This is intended for deployment in something like a Token Factory or Mist wallet, and then used by humans.
Imagine coins, currencies, shares, voting weight, etc.
Machine-based, rapid creation of many tokens would not necessarily need these extra features or will be minted in other manners.

1) Initial Finite Supply (upon creation one specifies how much is minted).
2) In the absence of a token registry: Optional Decimal, Symbol & Name.
3) Optional approveAndCall() functionality to notify a contract if an approval() has occurred.

.*/

import "./StandardToken.sol";

pragma solidity ^0.4.8;

contract BlockchainSaxonyMeetupCoin is StandardToken {

    /* Public variables of the token */

    /*
    NOTE:
    The following variables are OPTIONAL vanities. One does not have to include them.
    They allow one to customise the token contract & in no way influences the core functionality.
    Some wallets/interfaces might not even bother to look at this information.
    */
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show. ie. There could 1000 base units with 3 decimals. Meaning 0.980 SBX = 980 base units. It's like comparing 1 wei to 1 ether.
    string public symbol;                 //An identifier: eg SBX
    string public version = '0.1';       //human 0.1 standard. Just an arbitrary versioning scheme.
    bytes32 public secret;
    address public owner;
    address[] public members;
    Meetup [] public meetup;
    
    struct Meetup {
        
        uint nummer;
        address[] member;
        uint[][] signer;
    }
    
    function BlockchainSaxonyMeetupCoin() {
        totalSupply = 0;                        // Update total supply
        name = "BlockchainSaxonyMeetupCoin";                                   // Set the name for display purposes
        decimals = 0;                            // Amount of decimals for display purposes
        symbol = "SAX";                               // Set the symbol for display purposes
        owner = msg.sender;
        members.push(0xdd870fa1b7c4700f2bd7f44238821c26f7392148);
        // {Five} initial members. DAO similiar structure to govern the SAX token.
        // They can add new members. Give out tokens. Delete members.
        // Members give permissions to each others wheather they get tokens for a specific meetup.
        // Need at least {two} existing members of the SAX meetup to become a member.
        // Implementation: 
        //    3-dimensional array
        //      1. Meetup date
        //      2. List of members who confirm this member in general
        //      3. List of members who confirm if the member is present at the Meetup date. array.[m]
        
    }

    function isMember(address m) returns (bool success){
        for (uint mem_count = 0; mem_count < members.length; mem_count++) {
        if (m == members[mem_count]){
                    bool isMember = true;
                    mem_count = members.length;
                }
            }
            require (isMember);
    }

    function sign(address dude, address dude2) {
        require(isMember(dude));                // Check if member
        require(isMember(dude2));               // Check if member
        Meetup m = meetup[meetup.length--]      // Lookup last meetup
        require(m.member.dude);                 // Check if present at last meetup
        require(m.member.dude2);                // Check if present at last meetup
        // not finished
        
    }
    
    function getToken(bytes32 _secret) returns (bool success) {
        if (_secret == secret) { // TODO require
            for (uint mem_count = 0; mem_count < members.length; mem_count++) {
                if (msg.sender == members[mem_count]){
                    bool isMember = true;
                    mem_count = members.length;
                }
            }
            require (isMember);
            uint256 amount = 5;
            totalSupply += amount;
            balances[msg.sender] += amount;
            return true;
        } else {
            return false;
        }
    }
    
    function setMembers(address _member) returns (bool success) {
        require(msg.sender == owner);
        members.push(_member);
        return true;
    }
    
    function setSecret(bytes32 _secret) {
        require(msg.sender == owner);
        secret = _secret;
    }
    
    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
        //it is assumed when one does this that the call *should* succeed, otherwise one would use vanilla approve instead.
        require(_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData));
        return true;
    }
 
}
