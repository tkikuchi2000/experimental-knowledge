---
title: "Portainer Install"
date: 2018-06-24T10:52:34+09:00
draft: false
description: ""
featured_image: "/images/portainer-logo.png"
tags: [portainer, docker]
toc: true
---

## インストール

参考: [Deployment](http://portainer.readthedocs.io/en/stable/deployment.html)

### Quick start

`docker`コマンド

```bash
$ docker volume create portainer_data
$ docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer
```

`docker-compose`コマンド

```bash
$ docker-compose up -d
```

```yml
$ cat docker-compose.yml
version: '2'
services:
  portainer:
    image: portainer/portainer
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    restart: always

volumes:
  portainer_data:
```

### Docker for Windows Ver.18.03~ の注意点

Docker for Windows Ver.18.03.0 で`docker-compose`を利用すると、以下のエラー発生

- dockerコマンドでは発生しない。
- Docker for Windows Ver. 17.06.1では発生しない。

```dos
D:\xxx\portainer> docker-compose --version
docker-compose version 1.21.1, build 7641a569

D:\xxx\portainer> docker --version
Docker version 18.03.1-ce, build 9ee9f40

D:\xxx\portainer> docker-compose up -d
Recreating 9455d5e774ca_portainer_portainer_1 ... error

ERROR: for 9455d5e774ca_portainer_portainer_1  Cannot create container for service portainer: b'Mount denied:\nThe source path "\\\\var\\\\run\\\\docker.sock:/var/run/docker.sock"\nis not a valid Windows path'

ERROR: for portainer  Cannot create container for service portainer: b'Mount denied:\nThe source path "\\\\var\\\\run\\\\docker.sock:/var/run/docker.sock"\nis not a valid Windows path'
ERROR: Encountered errors while bringing up the project.
```

- 対処

1. WSLを利用し、 export DOCKER_HOST=tcp://127.0.0.1:2375 で起動
2. Ver. 17.06にダウングレード
3. 環境変数 COMPOSE_CONVERT_WINDOWS_PATHS=1 を指定して起動
    - cmd: 
      - `set COMPOSE_CONVERT_WINDOWS_PATHS=1; docker-compose up -d`
    - powershell: 
      - `$Env:COMPOSE_CONVERT_WINDOWS_PATHS=1; docker-compose up -d`
    - git-bash: 
      - `export COMPOSE_CONVERT_WINDOWS_PATHS=1; docker-compose up -d`
4. 環境変数 COMPOSE_CONVERT_WINDOWS_PATHS=1 を.envに指定

以下、4.の対処方法

docker-compose.ymlで`env_file`の追加

```yml
version: '2'
services:
  portainer:
    image: portainer/portainer
    ports:
      - "9000:9000"
    env_file:
      - .env
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    restart: always

volumes:
  portainer_data:
```

.envの編集

```bash
$ echo 'COMPOSE_CONVERT_WINDOWS_PATHS=1' >> .env
```

以後、正常に`docker-compose`で起動可能

```dos
D:\xxx\portainer> docker-compose up -d
Starting portainer_portainer_1 ... done
```


{{< figure src="/images/portainer.gif" title="" >}}
