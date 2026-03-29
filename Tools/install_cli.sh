#!/bin/sh
set -eu

CLI_VERSION="4.0.5.26748"
CLI_HASH="5a393c9d62136ea14a522964bd7d64c74a56c025f6561f51a873f9a288118924"
CLI_URL="https://www.gd32mcu.com/data/documents/toolSoftware/GD32_ISP_CLI_Linux_V${CLI_VERSION}.tar.gz"

if [ -d "GD32_ISP_CLI" ]; then
  echo "Target directory \"GD32_ISP_CLI\" already exists."
  exit 1
fi

if [ ! -e "$(basename ${CLI_URL})" ]; then
  echo "Downloading CLI archive \"$(basename ${CLI_URL})\"..."
  curl -sLO ${CLI_URL}
else
  echo "Found existing archive."
fi

echo "Verifying archive hash..."
echo "${CLI_HASH} $(basename ${CLI_URL})" | sha256sum -c -

echo "Extracting archive..."
tar -xzf $(basename ${CLI_URL})

echo "Done!"