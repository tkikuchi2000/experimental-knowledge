---
title: "Geth Install"
date: 2018-06-03T10:01:10+09:00
draft: false
description: ""
featured_image: "/images/ethereum_logo.png"
tags: [docker, ethereum, blockchain, geth, go]
toc: true
---

# Geth Install

参考：[Install the Ethereum CLI](https://ethereum.org/cli)
参考：[ethereum/client-go](https://hub.docker.com/r/ethereum/client-go/)
参考：[プライベート・ネットワークに接続する](https://book.ethereum-jp.net/first_use/connect_to_private_net.html)

## Dockerイメージ ダウンロード

Official Dockerイメージを利用

{{< highlight docker >}}
$ docker pull ethereum/client-go
{{< /highlight >}}

## Dockerコンテナ作成/起動

`docker-compose`の場合

{{< highlight yml >}}
# コンテナ起動
$ docker-compose up -d 
# コンテナ停止/再起動
$ docker-compose [stop|start]

# docker-compose.yml
version: '3'
services:
  client-go:
    image: ethereum/client-go:latest

# docker-compose.override.yml
version: '3'
services:
  client-go:
    volumes:
      - "./ethereum:/root/.ethereum"
    ports:
      - "30303:30303"
      - "8545:8545"
      - "8080:8080"
    command: '--dev --rpc --rpcapi "db,eth,net,web3,personal,admin,miner" --rpccorsdomain="*" --rpcaddr "0.0.0.0"'

{{< /highlight >}}

`docker`コマンドの場合

{{< highlight docker >}}
# コンテナ起動
$ docker run -it --name 'client-go' \
  -p '8545:8545' -p '8080:8080' -p '30303:30303' \
  -v './ethereum:/root/.ethereum' \
  --entrypoint='/bin/sh' \
  ethereum/client-go:latest

# コンテナ上のシェルを実行
$ docker exec -ti client-go sh

# gethコマンド実行
/# geth --dev \
    --rpc \
    --rpcaddr "0.0.0.0" \
    --rpcapi "db,eth,net,web3,personal,admin,miner" \
    --rpccorsdomain="*" \
    console

# 停止/再起動
$ docker [stop|start]  client-go
$ 上記 docker execで、gethを起動
{{< /highlight >}}

## Gethコンソール

- ホスト上で新たにコンソールをattachする場合、8545ポートを指定して、`geth attach`を実行。
- ホスト上にgethコマンドがインストールされていない場合は、コンテナ上で実行する。

{{< highlight bash >}}
# Gethコンソール
$ geth attach rpc:http://localhost:8545
Welcome to the Gth JavaScript console!

# Gethコンソール(コンテナで実行) 
$ docker-compose exec client-go sh
または
$ docker exec -ti client-go sh
/# geth attach rpc:http://localhost:8545
Welcome to the Gth JavaScript console!
{{< /highlight >}}

## ログ確認

{{< highlight docker >}}
$ docker-compose logs -f client-go
または
$ docker logs -f client-go
{{< /highlight >}}

## Geth起動オプション, 引数

{{< highlight bash >}}
$ geth --dev \
    --networkid "1337" \
    --rpc \
    --rpcaddr "0.0.0.0" \
    --rpcapi "db,eth,net,web3,personal,admin,miner" \
    --rpccorsdomain="*" \
    console
{{< /highlight >}}

### プライベートネット

- `--dev`オプションで起動。 

マイニングはトランザクションが生成されたときに自動で実行される。
起動時に自動で作成されたアカウントがetherbaseに紐づけされており、すでに大量のetherを所有している

{{< highlight js >}}
> eth.accounts
["0x9a1c54f16dde5a5a13b0909ecd9e085e89929d91"]
> eth.coinbase
"0x9a1c54f16dde5a5a13b0909ecd9e085e89929d91"
> eth.getBalance(eth.accounts[0])
1.15792089237316195423570985008687907853269984665640564039457584007913129639927e+77
{{< /highlight >}}

参考：[ethereum.stackexchange How do I set up a private ethereum network?](https://ethereum.stackexchange.com/questions/125/how-do-i-set-up-a-private-ethereum-network/2571#2571)


### Remote Procedure Call API

以下のオプションで適宜指定。

- `--rpc`
- `--rpcaddr`
- `--rpcapi`
- `--rpccorsdomain`

### コンソール

- 起動時に`console`を指定することで、geth実行時にattachできる。
