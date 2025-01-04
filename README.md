## prepare

### 初めに一回実施

```bash
# Terraform 対象サーバーで実行
$ echo 'security_driver = "none"' | sudo tee /etc/libvirt/qemu.conf > /dev/null
$ sudo systemctl restart libvirtd

# Terraform 実行サーバーで実行
$ sudo apt update -y \
  sudo apt install -y mkisofs

$ terraform providers lock -platform=linux_amd64
```

### 定期的に実施

```bash
$ cd terraform/modules/common/
$ wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
```

### LB の修正

```bash
# haproxy と keepalived の設定ファイルの Jinja テンプレートを生成する
$ cd ./ansible/files/lb/config_gen && \
  rm -rf .venv && \
  python -m venv .venv && \
  source .venv/bin/activate && \
  pip install --upgrade pip && \
  pip install -r requirements.txt && \
  python haproxy.py && \
  python keepalived.py
```

### 1password

```bash
# 以下２ファイルを設置
./ansible/files/1password/1password-credentials.json
./ansible/files/1password/connect_api_token.txt
```

## Usage

```bash
$ ./recreate-k8s.sh
```

## Clean Up

```bash
$ terraform -chdir=./terraform/env destroy -auto-approve -input=false
# nfsを使っている場合、base2で実行する
$ sudo rm -rf /mnt/nfsshare/k8s/share/*
```

```bash
$ kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
