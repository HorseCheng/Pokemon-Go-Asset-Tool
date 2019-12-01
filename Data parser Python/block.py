# -*- coding: utf-8 -*-
"""
Created on Wed Nov 13 09:46:50 2019

@author: ihors
"""

from web3 import Web3
from web3.middleware import geth_poa_middleware
import json

ganache_url='http://127.0.0.1:8545'
web3=Web3(Web3.HTTPProvider(ganache_url))

web3.eth.defaultAccount=web3.eth.accounts[0]
abi=json.loads('[{"constant":true,"inputs":[{"name":"a","type":"string"},{"name":"b","type":"string"}],"name":"compareStrings","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"a","type":"string"},{"name":"b","type":"uint256"},{"name":"c","type":"uint256"},{"name":"d","type":"uint256"},{"name":"e","type":"uint256"},{"name":"f","type":"uint256"},{"name":"g","type":"uint256"},{"name":"h","type":"uint256"},{"name":"i","type":"string"},{"name":"j","type":"string"},{"name":"k","type":"uint256"}],"name":"setData","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"a","type":"string"}],"name":"getData","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"printfunc","outputs":[{"name":"","type":"string[]"},{"name":"","type":"uint256[]"},{"name":"","type":"uint256[]"},{"name":"","type":"uint256[]"},{"name":"","type":"uint256[]"},{"name":"","type":"uint256[]"},{"name":"","type":"uint256[]"},{"name":"","type":"uint256[]"},{"name":"","type":"string[]"},{"name":"","type":"string[]"},{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"}]')
address=web3.toChecksumAddress('0x8a88786aae68633627a47d594d1fe789b31bb8a1')

contract=web3.eth.contract(address=address,abi=abi)


web3.middleware_onion.inject(geth_poa_middleware,layer=0)

tx_hash=contract.functions.setData("6860305399",118,45,42,31,3,13,67158,"25.11680467","121.262867",1618).transact()
web3.eth.waitForTransactionReceipt(tx_hash)
tx_hash=contract.functions.getData("6860305399").transact()
web3.eth.waitForTransactionReceipt(tx_hash)
print('Output: {}'.format(contract.functions.printfunc().call()))