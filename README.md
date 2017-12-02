## GCPのinstanceを作成

ZoneによってGPUが使えなかったりする。今回選ぶのは、

- us-west1-b
- ubuntu-16.04
- 10GB

コマンドラインからの起動と終了

```
gcloud compute instances start <inst>
gcloud compute instances stop <inst>
gcloud compute instances list
```

SSHでの接続。git initでデフォルトのプロジェクトが設定されている場合はinstance指定だけ

```
gcloud compute ssh instance-ml
```

設定されていない場合は、zoneやprojectを指定

```
gcloud compute ssh --zone=us-west1-b --project "GCP Tutorial" <inst>
```

GCPは、インスタンスを起動する度にIPが変わるので文句言われるが無視

ファイルのコピー

```
gcloud compute copy-files localfiles instance-ml:/home/shun
```

## DockerのInstall

dockerはもともとmicroservice向け
dockerはまずアンインストールして、docker-ceをいれる

```
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update
sudo apt-get install docker-ce
sudo docker run hello-world
```

## Dockerの作成

- Dockerfile
- processとfile
- sudo mount filesystemでマウントされているモジュールを確認
- DiskとProcess
- ImageとCcontainer

- Docker

  - コンテナ
  - イメージ

      - union mount
      - layered

```
sudo usermod -a -G docker $USER
exit
gcloud compute ssh instance-ml
docker build -t tsunoda/hello .


同じアーキで立ち上げるとオーバーヘッドがない、アーキが異なるとVMあげたりいろいろする
dockerはプロセス

```
docker images
docker run -ti --rm tsunoda/hello
```

一時的なレイヤを残さない、--rm
RUNコマンドのハッシュを見てDockerはキャッシュする
コマンドがレイヤになる
append-only

```
apt-get update
apt-get install python3.5 -y
apt-get install python3-pip -y
apt-get install python3-dev -y
```

docker build -t tsunoda/python3 .

dockr run -ti tsunoda/python3 --rm
pip3 install jupyter pandas
jupyter notebook --ip='*' --allow-root
```

```
docker run -ti --rm --publish 50000:8888 tsunoda/jupyter
```

Port forwardのやり方

--L remote:localhost:port

gcloud compute ssh instance-ml -- -L 50001:localhost:50000
jupyter notebook --ip='*' --allow-root

sudo apt-get install -y git

tmux

- Ctrl-b
  - "
  - %
  - SPC
  - o
  - z

```
docker run -ti --rm --publish 50000:8888 -v $PWD:/work tsunoda/tensorflow
```
