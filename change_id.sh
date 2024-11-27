#!/bin/bash

# 配置文件路径
STORAGE_FILE="$HOME/Library/Application Support/Cursor/User/globalStorage/storage.json"

# 生成随机 ID
generate_random_id() {
    openssl rand -hex 32
}

# 生成新的 ID
NEW_ID=${1:-$(generate_random_id)}

# 创建备份
backup_file() {
    if [ -f "$STORAGE_FILE" ]; then
        cp "$STORAGE_FILE" "${STORAGE_FILE}.backup_$(date +%Y%m%d_%H%M%S)"
        echo "已创建备份文件"
    fi
}

# 确保目录存在
mkdir -p "$(dirname "$STORAGE_FILE")"

# 创建备份
backup_file

# 如果文件不存在，创建新的 JSON
if [ ! -f "$STORAGE_FILE" ]; then
    echo "{}" > "$STORAGE_FILE"
fi

# 更新 machineId
tmp=$(mktemp)
perl -i -pe 's/"telemetry\.machineId":\s*"[^"]*"/"telemetry.machineId": "'$NEW_ID'"/' "$STORAGE_FILE"

echo "已成功修改 machineId 为: $NEW_ID"