#!/bin/bash

cd "$(dirname "$0")" || exit

rm -f ~/.ssh/known_hosts ~/.ssh/known_hosts.old

# 追加したいVMのIPアドレスまたはホスト名のリスト
VM_LIST=(
  "192.168.11.131"
  "192.168.11.132"
  "192.168.11.141"
  "192.168.11.142"
  "192.168.11.143"
  "192.168.11.151"
  "192.168.11.152"
  "192.168.11.153"
  )

# ~/.ssh/known_hostsファイルに書き込む
for VM in "${VM_LIST[@]}"; do
    echo "Adding $VM to known_hosts..."
    ssh-keyscan "$VM" >> ~/.ssh/known_hosts
done

echo "All keys have been added to ~/.ssh/known_hosts."

# ansible-playbookコマンドを実行
ansible-playbook --key-file ~/.ssh/main -i inventory.yml playbook.yml
