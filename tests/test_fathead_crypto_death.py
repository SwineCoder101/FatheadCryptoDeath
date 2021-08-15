import pytest
from brownie import FatHeadCryptoDeath, accounts,config
from scripts.helpful_scripts import get_account

@pytest.fixture(scope="module")
def token():
    token =FatHeadCryptoDeath.deploy({"from": get_account()})
    token.flipSaleState({'from': get_account()})
    token.setBaseURI("https://ipfs.io/ipfs/QmZQfuH5HQAet4M2QyXGtQJYJpP9a8erS8KjWCHCwNrsKi/",{'from': get_account()})
    return token

def test_can_mint_fathead_tokens(token):
    token.mintFatHead(1,{'from': accounts[1],'amount':110000000000000000})
    assert token.ownerOf(0) == accounts[1]

def test_should_not_allow_payment_for_unsufficient_funds(token):
    token.mintFatHead(2,{'from': accounts[1],'amount':110000000000000000})

def test_should_burn_tokens(token):
    token.mintFatHead(2,{'from': accounts[1],'amount':110000000000000000})
    token.burnTwoForOne(0,1,{'from': accounts[1],'amount':110000000000000000})
    assert token.ownerOf(0) != accounts[1]
    assert token.ownerOf(1) != accounts[1]
    assert token.ownerOf(2) == accounts[1]