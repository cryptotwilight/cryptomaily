const icmPouchAbi = [
	{
		"inputs": [],
		"name": "getCreator",
		"outputs": [
			{
				"internalType": "address",
				"name": "_pouchCreatorAddress",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getFundsData",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_fundsTotal",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_pouchDenomination",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getName",
		"outputs": [
			{
				"internalType": "string",
				"name": "pouchName",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getOwner",
		"outputs": [
			{
				"internalType": "address",
				"name": "_pouchOwnerAddress",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getStatus",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_isDetached",
				"type": "bool"
			},
			{
				"internalType": "string",
				"name": "_status",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_fundsTotal",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_pouchDenomination",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_nftCount",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			}
		],
		"name": "lock",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_locked",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "pullFunds",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_erc20List",
				"type": "address[]"
			},
			{
				"internalType": "uint256",
				"name": "_pouchTotal",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "pullNFTs",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_nftContractList",
				"type": "address[]"
			},
			{
				"internalType": "uint256",
				"name": "_nftTotal",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_funds",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_erc20",
				"type": "address"
			}
		],
		"name": "storeFunds",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_pouchTotal",
				"type": "uint256"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_id",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_eip1559",
				"type": "address"
			}
		],
		"name": "storeNFT",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_nftTotal",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_newOnwer",
				"type": "address"
			}
		],
		"name": "transferTo",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_isTransfered",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "unlock",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_locked",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]