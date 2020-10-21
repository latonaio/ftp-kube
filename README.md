# ftp-kube

・汎用ftpサーバコンテナを立てる

・ホスト側からもアクセス可能（ポート20,21）

・ftpユーザのNAME,PWはyamlファイル内に環境変数定義している

### 準備

・ftp-deployment.yamlとftp-outward-deployment.yamlにftpユーザのID,PWを設定する

・KEYENCEの機械のftpアクセスID,PWを上記設定したものに合わせる

・vsftpd_outward.confのpasv_addressに、Jetsonの有線LANの固定IPを設定する

・ftp_confに設定ファイルを配置

```
$ sudo cp vsftpd.conf /mnt/ftp_conf/
$ sudo cp vsftpd_outward.conf /mnt/ftp_conf/
```

・ftp_dataディレクトリの権限を、誰でも書き込み可能(drwxrwxrwx)にしておく

```
$ sudo mkdir /mnt/ftp_data
$ sudo chmod 777 /mnt/ftp_data
```

・kube-apiserverの設定を変更する

```
$ sudo vim /etc/kubernetes/manifests/kube-apiserver.yaml
下の１行を追加
  - --service-node-port-range=1-40000
```

・デプロイ

```
$ k apply -f ftp-deployment.yaml -f ftp-outward-deployment.yaml
```

### 内容

ftp

・podネットワーク内からのみアクセス可能なftpサーバ

ftp-outward

・kubernetesの外からのみアクセス可能なftpサーバ

※両者は扱うファイルを共有しているため、外側と内側でファイルの受け渡しが可能となっている
