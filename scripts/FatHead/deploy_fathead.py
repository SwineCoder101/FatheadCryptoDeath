#!/usr/bin/python3
import os
from brownie import FatHeadCryptoDeath, accounts, network, config

def main():
    max=10
    dev = accounts.add(config["wallets"]["from_key"])
    print(network.show_active())
    publish_source = True if os.getenv("ETHERSCAN_TOKEN") else False
    # FatHeadCryptoDeath.deploy({"from": dev})
    FatHeadCryptoDeath.deploy({"from": dev}, publish_source=publish_source)
