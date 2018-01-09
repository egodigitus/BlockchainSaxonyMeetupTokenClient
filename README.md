# A Token for the Blockchain Meetup Saxony 

## Why this token
This Token is meant to be an incentive inside [the meetup group](https://www.meetup.com/de-DE/BlockchainMeetupSaxony/). 

The meetup is divided in two separate events: Regular meetup & hands-on. Both happen about once a month. 
The token is supposed to reward physical appearance at the meetups and reward contributions like e.g. talks, workshops or being host of a meetup.
The token is developed in the hands-On of the meetup by voluntary enthusiasts and serves after all the properties of a self-educational project. 

## Development
The token is developed using an Ethereum smart contract. The [initial prototype application](http://bcsmtocken.ddns.net/) was developed by [Leo](https://github.com/lsmobile) and is interacting with the Ropsten testnet. The [smart contract code](https://github.com/egodigitus/BlockchainSaxonyMeetupTokenClient/commit/88ef8a62fff85b22cd5538c882c78aa82349f538) for this application is an early commit in this repo.
Original smart contract deployed on Ropsten: https://ropsten.etherscan.io/address/0xa316e5f639e3224b60198e869d33f621f9bb2979

### Main problem:
**Authentication:** People who show physical appearance at a meetup shall be rewarded with tokens. How can we build a secure and simple way to proof against the blockchain that a human has been at a certain meetup? Any simple "secret" that is sent towards the smart contract can be seen on the blockchain and could be reused by an attacker to gain tokens without permission.

**Solution approach 1** (git branch: master)</br>
A two-step cryptographic setup to solve this:

1. A secret is announced locally during a meetup. Client takes secret as input, combines it with his Ethereum address (XOR) and hashes the result.
The client sends this result to the smart contract. The **smart contract doesn't know yet the secret**. With all clients sending their results towards the smart contract, first phase finishes.
2. The owner of the contract sends the secret towards in plain towards the smart contract. Loop: secret gets combined (XOR) with address and compared to the result sent earlier. If correct the address gets X amount of tokens.

**Solution approach 2** (git branch: DAO)</br>
{Five} initial members. DAO similiar structure to govern the token.
They can add new members. Give out tokens. Delete members.
Members give permissions to each other during the meetup, wheather they appeared at a specific meetup and get tokens.
Need at least {two} existing members of the meetup to become a member.
