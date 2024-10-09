// queries for logs with two topics, with both topics set explictly
>> {"jsonrpc":"2.0","id":1,"method":"eth_getLogs","params":[{"address":null,"fromBlock":"0x2","toBlock":"0x5","topics":[["0x00000000000000000000000000000000000000000000000000000000656d6974"],["0x16c82ec8f9ca85b24056a511f7cf791544abe2afe8e59f0d08d17bc2cdc99f81"]]}]}
<< {"jsonrpc":"2.0","id":1,"result":[{"address":"0x7dcd17433742f4c0ca53122ab541d0ba67fc27df","topics":["0x00000000000000000000000000000000000000000000000000000000656d6974","0x16c82ec8f9ca85b24056a511f7cf791544abe2afe8e59f0d08d17bc2cdc99f81"],"data":"0x0000000000000000000000000000000000000000000000000000000000000004","blockNumber":"0x3","transactionHash":"0x33c37088ffa73006e75a5c4baacadcfb0aa42a33917b8eec7b3a987cec6c44dd","transactionIndex":"0x2","blockHash":"0x5204c8e7c8a14bcbd6031520d70b2531999f4f8d587603659f1fb1c82935bcd4","logIndex":"0x2","removed":false}]}
