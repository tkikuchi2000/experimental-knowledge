---
title: "Geth: プライベートネットワーク作成2"
date: 2018-06-03T14:09:05+09:00
draft: false
description: "アカウント作成～マイニング"
featured_image: "/images/ethereum_logo.png"
tags: [docker, ethereum, blockchain, geth, go]
toc: true
---

# アカウント作成～マイニング

参考：[etherを採掘する](https://book.ethereum-jp.net/first_use/mining_ether.html)
参考：[ethereum/client-go](https://hub.docker.com/r/ethereum/client-go/)

## コンソールに接続

`geth attach`

{{< highlight bash >}}
$ geth attach rpc:http://localhost/8545
Welcome to the Geth JavaScript console!
[...]
>
{{< /highlight >}}

## EOAアカウント作成

`personal.newAccount(<pass phrase>)`

{{< highlight js >}}
// ユーザ1
> personal.newAccount('thisistestpassphrase')
"0x4dcf8b9a667869feb9a20f96ee9d4c12a72a7c76"
// ユーザ2
> personal.newAccount("thisistestpassphrase2")
"0xd7acd244088c9af95ec5c4c66753c21cc0f827e1"

// アカウントの表示
> eth.accounts
["0x4dcf8b9a667869feb9a20f96ee9d4c12a72a7c76", "0xd7acd244088c9af95ec5c4c66753c21cc0f827e1"]
{{< /highlight >}}

## etherbaseの割り当て

マイニング報酬を紐づけるEOAアカウントを指定

{{< highlight js >}}
// アカウントリスト
> eth.accounts
["0x4dcf8b9a667869feb9a20f96ee9d4c12a72a7c76", "0xd7acd244088c9af95ec5c4c66753c21cc0f827e1"]
// etherbase割当
> miner.setEtherbase(eth.accounts[1])
true
// coinbase表示
> eth.coinbase
"0xd7acd244088c9af95ec5c4c66753c21cc0f827e1"
{{< /highlight >}}

## マイニング

`miner.start(<thread_num>)`

マイニングの開始・停止

{{< highlight js >}}
// CPUの実行スレッド数を引数で渡す
> miner.start(4)
null
// マイニング停止
> miner.stop()
true
{{< /highlight >}}

マイニング状況の確認

{{< highlight js >}}
// マイニング実行確認
> eth.mining
> true / false
// 実行ハッシュレート
> eth.hashrate
> 445445 / 0
// 採掘済ブロック数
> eth.blockNumber
> 145
{{< /highlight >}}
