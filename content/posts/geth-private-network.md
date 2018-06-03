---
title: "Geth: プライベートネットワーク作成"
date: 2018-06-03T13:09:05+09:00
draft: true
description: ""
featured_image: "/images/ethereum_logo.png"
tags: [docker, ethereum, blockchain, geth, go]
toc: true
---

`--dev`で起動した場合は、以下の手順は不要。

# Genesisファイルを作成

`eth_private_net/myGenesis.json`

{{< highlight json >}}
{
  "config": {
    "chainId": 15
  },
  "nonce": "0x0000000000000042",
  "timestamp": "0x0",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "extraData": "",
  "gasLimit": "0x8000000",
  "difficulty": "0x4000",
  "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": "0x3333333333333333333333333333333333333333",
  "alloc": {}
}
{{< /highlight >}}

# Genesisブロックの初期化

以下のコマンドを実行すると、--datadirで指定したディレクトリ以下にディレクトリが新しく作成されて、その中にgenesisブロックのブロックチェーン情報が保存される。

{{< highlight bash >}}
$ geth --datadir /root/eth_private_net \
     init \
     /root/eth_private_net/myGenesis.json
{{< /highlight >}}

# Geth起動

- `--networkid`に、GenesisブロックのChainIDと同じIDを指定
- `--datadir`にGenesisブロック初期化時と同じディレクトリを指定
- `--nodiscover`で、p2pノード探索を無効

{{< highlight bash >}}
$ geth --networkid "15" \
    --nodiscover
    --datadir /root/eth_private_net 
    console 2>> /root/eth_private_net/geth_err.log
{{< /highlight >}}

Genesisブロック情報を確認 

{{< highlight js >}}
> eth.getBlock(0)
[...]
{{< /highlight >}}
