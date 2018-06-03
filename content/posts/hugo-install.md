---
title: "hugo install"
date: 2018-06-02t11:56:12+09:00
draft: true
description: ""
featured_image: "/images/hugo-logo.png"
tags: [hugo]
toc: true
---

# Getting Started

## インストール

参考: [Install Hugo](https://gohugo.io/getting-started/installing/)

### homebrew(macOS)

```bash
$ brew install hugo
```

### chocolatey(Windows)

```bash
> choco install hugo -confirm
```

### apt-get(Ubuntu)

```bash
$ apt-get install hugo
```

## Pygmentsインストール (Optional)

[ソースコードハイライト](https://gohugo.io/content-management/shortcodes/#highlight)のためにインストール

```bash
$ pip install Pygments
```

Shortcode: `highlight language`

---

## Quick Start

参考: [Quick Start](https://gohugo.io/getting-started/quick-start/)

### サイト新規作成 

```bash
$ hugo new site <site-name> 
$ cd <site-name>
$ git init
```

### テーマ追加

[themes.gohugo.io](https://themes.gohugo.io/)からテーマを選択

```bash
# git submodule で追加
$ git submodule add <repo-url> themes/<theme-name>
# 設定ファイルにテーマをセット
$ echo 'theme = "<theme-name>"' >> config.toml
```

### コンテンツ追加

```bash
$ hugo new posts/<post-name>.md
```

### ドラフト確認用サーバ起動

起動後`http://localhost:1313/`にアクセス

```bash
$ hugo server -D
Started building sites ...
[...]
Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

### ディレクトリ構造

```bash
.
├── archetypes/
├── config.toml/
├── content/
├── data/
├── layouts/
├── static/
├── themes/
└── config.toml
```

**archetypes**

 `hugo new`のテンプレートを設置  
 
- See: [archetypes](https://gohugo.io/content-management/archetypes/)

**content**

コンテンツを、セクションごとのディレクトリに分けて設置する。

- See: [content types](https://gohugo.io/content-management/types/)

**data**

HugoがWebサイト生成時に使われる設定ファイルを設置

- See: [data templates](https://gohugo.io/templates/data-templates/)

**layouts**

`.html`ファイルのテンプレートを設置

- See:
  - [list pages](https://gohugo.io/templates/list/)
  - [homepage](https://gohugo.io/templates/homepage/)
  - [taxonomy templates](https://gohugo.io/templates/taxonomy-templates/)
  - [partials](https://gohugo.io/templates/partials/)
  - [single page templates](https://gohugo.io/templates/single-page-templates/)

**static**

アセット(images, CSS, JavaScript, etc.)を設置

Manageing Example: [Hugo starter kits](https://gohugo.io/tools/starter-kits/)


**config.toml**

Hugo Project設定ファイル 

See: [configuration directives](https://gohugo.io/getting-started/configuration/#all-variables-yaml)
