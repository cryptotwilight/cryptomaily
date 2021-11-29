const icryptoMailyAbi = [
	{
		"inputs": [],
		"name": "createMessage",
		"outputs": [
			{
				"internalType": "address",
				"name": "_messageAddress",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_messageAddress",
				"type": "address"
			}
		],
		"name": "deleteMessage",
		"outputs": [
			{
				"internalType": "string",
				"name": "_deleteStatus",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getAllInboxMail",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_messageAddresses",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getDrafts",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_draftAddresses",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_dateMillis",
				"type": "uint256"
			}
		],
		"name": "getInboxMail",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_messageAddresses",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSentMail",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_messageAddresses",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_messageAddress",
				"type": "address"
			}
		],
		"name": "sendMessage",
		"outputs": [
			{
				"internalType": "string",
				"name": "_sendStatus",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]