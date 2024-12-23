#!/bin/bash

# 配置文件路径 (Linux版本)
STORAGE_FILE="$HOME/.config/Cursor/User/globalStorage/storage.json"

# 检查必要命令
check_commands() {
    local commands=("openssl" "uuidgen" "perl")
    for cmd in "${commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "错误: 未找到命令 '$cmd'. 请先安装必要的工具。"
            exit 1
        fi
    done
}


# 生成随机 ID
generate_random_id() {
    openssl rand -hex 32 || {
        echo "生成随机ID失败"
        exit 1
    }
}

# 生成随机 UUID
generate_random_uuid() {
    uuidgen | tr '[:upper:]' '[:lower:]' || {
        echo "生成UUID失败"
        exit 1
    }
}

# 检查必要命令
check_commands

# 生成新的 IDs
NEW_MACHINE_ID=${1:-$(generate_random_id)}
NEW_MAC_MACHINE_ID=$(generate_random_id)
NEW_DEV_DEVICE_ID=$(generate_random_uuid)

# 创建备份
backup_file() {
    if [ -f "$STORAGE_FILE" ]; then
        cp "$STORAGE_FILE" "${STORAGE_FILE}.backup_$(date +%Y%m%d_%H%M%S)" || {
            echo "创建备份失败"
            exit 1
        }
        echo "已创建备份文件"
    fi
}

# 确保目录存在
mkdir -p "$(dirname "$STORAGE_FILE")" || {
    echo "创建目录失败"
    exit 1
}

# 创建备份
backup_file

# 如果文件不存在，创建新的 JSON
if [ ! -f "$STORAGE_FILE" ]; then
    echo "{}" > "$STORAGE_FILE" || {
        echo "创建配置文件失败"
        exit 1
    }
fi

# 检查文件是否可写
if [ ! -w "$STORAGE_FILE" ]; then
    echo "错误: 配置文件不可写"
    exit 1
fi

# 更新所有遥测 ID
perl -i -pe 's/"telemetry\.machineId":\s*"[^"]*"/"telemetry.machineId": "'$NEW_MACHINE_ID'"/' "$STORAGE_FILE" || {
    echo "更新 machineId 失败"
    exit 1
}
perl -i -pe 's/"telemetry\.macMachineId":\s*"[^"]*"/"telemetry.macMachineId": "'$NEW_MAC_MACHINE_ID'"/' "$STORAGE_FILE" || {
    echo "更新 macMachineId 失败"
    exit 1
}
perl -i -pe 's/"telemetry\.devDeviceId":\s*"[^"]*"/"telemetry.devDeviceId": "'$NEW_DEV_DEVICE_ID'"/' "$STORAGE_FILE" || {
    echo "更新 devDeviceId 失败"
    exit 1
}

echo "已成功修改 ID:"
echo "machineId: $NEW_MACHINE_ID"
echo "macMachineId: $NEW_MAC_MACHINE_ID"
echo "devDeviceId: $NEW_DEV_DEVICE_ID"
