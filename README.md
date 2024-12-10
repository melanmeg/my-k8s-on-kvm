# my-k8s-ansible

（自分用）k8s 構築用 Ansible

## prepare

```bash
$ terraform providers lock -platform=linux_amd64
```

```bash
# Terraform 対象サーバーで実行
$ echo 'security_driver = "none"' | sudo tee /etc/libvirt/qemu.conf > /dev/null
$ sudo systemctl restart libvirtd

# Terraform 実行サーバーで実行
$ sudo apt update -y \
  sudo apt install -y mkisofs
```

```bash
# haproxy と keepalived の設定ファイルの Jinja テンプレートを生成する
$ cd ./ansible/files/lb/config_gen
$ rm -rf .venv && \
  python -m venv .venv && \
  source .venv/bin/activate && \
  pip install --upgrade pip && \
  pip install -r requirements.txt && \
  python haproxy.py && \
  python keepalived.py
```

## Usage

```bash
$ ./recreate-k8s.sh
```

## Clean Up

```bash
# nfsを使っている場合、base2で実行する
$ sudo rm -rf /mnt/nfsshare/k8s/share/*
```
