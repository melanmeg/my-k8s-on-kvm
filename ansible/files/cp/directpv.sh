#!/bin/bash

OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')
KREW="krew-${OS}_${ARCH}"

# Set the maximum number of retries
max_retries=3
retry_count=0

# Repeat until validation is successful or max retries are reached
while [[ $retry_count -lt $max_retries ]]; do
  # Sleep for 5 seconds before running the command
  sleep 5

  {
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
    tar zxvf "${KREW}.tar.gz"
    ./"${KREW}" install krew

    kubectl krew install directpv
    kubectl directpv install --seccomp-profile seccomp.json
    kubectl directpv discover --output-file /tmp/drives.yaml --timeout 10s
    kubectl directpv init drives.yaml --dangerous
  } > /dev/null 2>&1

  # Get the output of the command
  output=$(kubectl directpv info)

  # Extract the last line to capture the drives info
  last_line=$(echo "$output" | tail -n 1)

  # Extract the number of drives from the last line
  drives=$(echo "$last_line" | grep -oP "\d+(?= drives)")

  # Validation logic
  if [[ -z "$drives" ]]; then
    echo "Error: Unable to retrieve the value of 'drives'. Please check the command output."
  fi

  if [[ "$drives" -eq 3 ]]; then
    echo "Validation successful: 3 drives detected."
    break
  else
    echo "Validation failed: $drives drives detected. Retrying... ($((retry_count+1))/$max_retries)"
  fi

  # Increment the retry counter
  ((retry_count++))
done

# If the loop reaches the maximum retries without success
if [[ $retry_count -ge $max_retries ]]; then
  echo "Validation failed after $max_retries attempts."
  exit 1
fi
