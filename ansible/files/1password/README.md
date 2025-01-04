## vault

### 準備

- シークレット自動化

  - 環境名： `kubernetes-connect`

- 保管庫名： `my-vault`

### 使用

```bash
$ helm repo add 1password https://1password.github.io/connect-helm-charts/
$ helm install connect 1password/connect \
  --version 1.8.1 \
  --create-namespace \
  --namespace 1password \
  --set-file connect.credentials=1password-credentials.json \
  --set-file operator.token.value=connect_api_token.txt \
  --values values.yaml
```

- example

```bash
$ kubectl apply -f - <<EOF
apiVersion: onepassword.com/v1
kind: OnePasswordItem
metadata:
  name: my-secret
  namespace: 1password
spec:
  itemPath: "vaults/my-vault/items/my-login"
EOF

$ kubectl get secret -n 1password -o yaml
```
