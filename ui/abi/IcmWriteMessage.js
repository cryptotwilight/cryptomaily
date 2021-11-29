const icmWriteMessageAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_attachmentName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_ipfsAttachmentHash",
				"type": "string"
			}
		],
		"name": "addAttachment",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_attachmentCount",
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
				"name": "_pouchAddress",
				"type": "address"
			}
		],
		"name": "addPouch",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_pouchCount",
				"type": "uint256"
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
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "_pouchDenomination",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "_pouchDenominationSymbol",
				"type": "string"
			}
		],
		"name": "createPouch",
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
		"name": "getAttachmentList",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "_attachmentName",
				"type": "string[]"
			},
			{
				"internalType": "string[]",
				"name": "_ipfsAttachmentHash",
				"type": "string[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getPouchList",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_pouchList",
				"type": "address[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_recipientAddress",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "_subject",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_ipfsMessageHash",
				"type": "string"
			}
		],
		"name": "setMessage",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_set",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc20",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "_symbol",
				"type": "string"
			}
		],
		"name": "setMessageDenomination",
		"outputs": [
			{
				"internalType": "string",
				"name": "_symb",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_recipientAddress",
				"type": "address"
			}
		],
		"name": "setRecipient",
		"outputs": [
			{
				"internalType": "address",
				"name": "_recipient",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]