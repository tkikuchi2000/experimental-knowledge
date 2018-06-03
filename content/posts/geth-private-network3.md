---
title: "Geth: プライベートネットワーク作成3"
date: 2018-06-03T15:09:05+09:00
draft: false
description: "送金"
featured_image: "/images/ethereum_logo.png"
tags: [docker, ethereum, blockchain, geth, go]
toc: true
---

# ether送金

参考: [etherの送金](https://book.ethereum-jp.net/first_use/sending_ether.html)

バランス確認

{{< highlight js >}}
// アカウント作成
 personal.newAccount('test')
"0x5b5f42f5e38c469b23ad18c40b67c91f96f59b0c"
> eth.accounts
["0x9a1c54f16dde5a5a13b0909ecd9e085e89929d91", "0x7d59985d4570503078564db2ebac05c8d9d93ce2", "0x5b5f42f5e38c469b23ad18c40b67c91f96f59b0c"]

// バランス確認 
> web3.fromWei(eth.getBalance(eth.accounts[1]), "ether")
1
> eth.getBalance(eth.accounts[2])
0
{{< /highlight >}}

1. 送金元アカウントのロック解除(`personal.unlockAccount()`)
2. 送金実行(`eth.sendTransaction()`)

{{< highlight js >}}
// アンロック～送金
> personal.unlockAccount(eth.accounts[1])
Unlock account 0x7d59985d4570503078564db2ebac05c8d9d93ce2
Passphrase:
true
> eth.sendTransaction({from: eth.accounts[1], to: eth.accounts[2], value: web3.toWei(0.5, "ether")})
"0xd22559eb889af11fa3d4bb827ef7b66da807d596ceec54769ef070f4064f4247" ... トランザクションID
{{< /highlight >}}

送金結果の確認

- トランザクション手数料 = 0.5 - 0.499999999999979 = 0.000000000000021 = 21000wei
- gas使用量 = 21000gas
- gasPrice = 21000wei / 21000gas = 1 wei

{{< highlight js >}}
// バランス確認
> web3.fromWei(eth.getBalance(eth.accounts[1]), "ether")
0.499999999999979
> web3.fromWei(eth.getBalance(eth.accounts[2]), "ether")
0.5

// 採掘ブロック確認
> eth.blockNumber
2

> eth.getBlock(2)
{
  difficulty: 2,
  extraData: "0xd88301080b846765746888676f312e31302e32856c696e757800000000000000b25304ebb7444a49a2022b241a3ef68fe5b1682363c9c9d3bad0b3d4045414284377f432537973cf033532e795c2e714624cced2e1d78d1f35e00b08b6f96b8001",
  gasLimit: 6270953,
  // gas使用量
  gasUsed: 21000,
  hash: "0xc0710eb7b7ecff5ac83805504f138d070b697bdd03a4e63aec04168b3919df48",
  logsBloom: "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
  // マイナー
  miner: "0x0000000000000000000000000000000000000000",
  mixHash: "0x0000000000000000000000000000000000000000000000000000000000000000",
  nonce: "0x0000000000000000",
  // ブロック高
  number: 2,
  // 親ブロックのハッシュ
  parentHash: "0x1b302423445fed899d10729b2301ef1bb9fdbccc27b9797a1d89ff1c716eb64b",
  receiptsRoot: "0x056b23fbba480696b65fe5a59b8f2148a1299103c4f57df839233af2cf4ca2d2",
  sha3Uncles: "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
  size: 717,
  stateRoot: "0xd9d6c12f4034774285eb85f705a4aa852a9ae25c1a21777a332a81d912f7f738",
  timestamp: 1528008788,
  totalDifficulty: 5,
  // 送金時のトランザクションID
  transactions: ["0xd22559eb889af11fa3d4bb827ef7b66da807d596ceec54769ef070f4064f4247"],
  transactionsRoot: "0x3d30a6ee1a5369f86fccea6ac22dcd1fd18025f20e00ac4f3c3d6c1accb92c3f",
  uncles: []
}
{{< /highlight >}}

トランザクション情報の確認

`eth.getTransaction()`

- トランザクション手数料: 21000wei
- 1gasあたりの手数料(gasPrice): 1wei
- gas使用量 = 21000wei / 1wei = 21,000 gas

{{< highlight js >}}
> eth.getTransaction('0xd22559eb889af11fa3d4bb827ef7b66da807d596ceec54769ef070f4064f4247')
{
  // このトランザクションを含んだブロックのヘッダハッシュ
  blockHash: "0xc0710eb7b7ecff5ac83805504f138d070b697bdd03a4e63aec04168b3919df48",
  // 同上のブロック高
  blockNumber: 2,
  // 送金元
  from: "0x7d59985d4570503078564db2ebac05c8d9d93ce2",
  // トランザクション処理時のgasの使用量の最大値
  gas: 90000,
  // 1gasあたりの手数料(wei)
  gasPrice: 1,
  hash: "0xd22559eb889af11fa3d4bb827ef7b66da807d596ceec54769ef070f4064f4247",
  input: "0x",
  nonce: 0,
  r: "0x2988c37dc9bee5e4263e5c3d78aee37277e2a6f7d3184c408bc452d730843bfa",
  s: "0x6148ab0af21e9bbd46c8730e00bfe1ff7910c1d2f0e054cd0f068ef472902f06",
  // 宛先
  to: "0x5b5f42f5e38c469b23ad18c40b67c91f96f59b0c",
  transactionIndex: 0,
  v: "0xa95",
  // 送金額(wei)
  value: 500000000000000000
}
{{< /highlight >}}