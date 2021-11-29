const icmReadMessageAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_pouchName",
				"type": "string"
			}
		],
		"name": "detachPouch",
		"outputs": [
			{
				"internalType": "address",
				"name": "_pouchAddress",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getAttachments",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "attachmentTitle",
				"type": "string[]"
			},
			{
				"internalType": "string[]",
				"name": "_ipfsAttachmentHashList",
				"type": "string[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMessage",
		"outputs": [
			{
				"internalType": "string",
				"name": "_ipfsMessageHash",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getPouches",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_pouchList",
				"type": "address[]"
			},
			{
				"internalType": "uint256",
				"name": "_totalPouchValue",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_messageDenomination",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_date",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getRecipient",
		"outputs": [
			{
				"internalType": "address",
				"name": "_recipient",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSender",
		"outputs": [
			{
				"internalType": "address",
				"name": "_sender",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSubject",
		"outputs": [
			{
				"internalType": "string",
				"name": "_subject",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getTransferStatus",
		"outputs": [
			{
				"internalType": "string",
				"name": "_transferStatus",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]