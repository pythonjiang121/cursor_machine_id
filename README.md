# Cursor Device ID Changer

一个用于修改 Cursor 编辑器设备 ID 的跨平台工具集。当遇到设备 ID 锁定问题时，可用于重置设备标识。

## 功能特性

- ✨ 支持 Windows 和 macOS 系统
- 🔄 自动生成符合格式的随机设备 ID
- 💾 自动备份原配置文件
- 🛠️ 支持自定义设备 ID（仅 macOS 版本）
- 📦 无需额外依赖，仅使用系统内置工具

## 使用说明

### Windows 系统

1. 下载 `win_change_id.bat` 脚本
2. 右键点击脚本，选择"以管理员身份运行"
3. 按照提示等待脚本执行完成

### macOS 系统

1. 下载 `mac_change_id.sh` 脚本
2. 打开终端，进入脚本所在目录
3. 添加执行权限：
```bash
chmod +x mac_change_id.sh
```
4. 运行脚本：
```bash
# 使用随机生成的设备 ID
./mac_change_id.sh

# 使用自定义设备 ID（可选）
./mac_change_id.sh your_custom_id
```

## 配置文件位置

### Windows
```
%APPDATA%\Cursor\User\globalStorage\storage.json
```

### macOS
```
~/Library/Application Support/Cursor/User/globalStorage/storage.json
```

## 注意事项

- 运行脚本前请确保已完全关闭 Cursor 编辑器
- 脚本会自动备份原配置文件，备份文件格式为 `storage.json.backup_时间戳`
- Windows 版本需要管理员权限运行
- 建议每次使用后检查 Cursor 是否正常运行

## 工作原理

脚本通过修改以下设备标识符来重置 Cursor 的设备识别：

- `telemetry.machineId`
- `telemetry.macMachineId`
- `telemetry.devDeviceId`
- `telemetry.sqmId`（仅 Windows 版本）

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=fly8888/cursor_machine_id&type=Area)](https://star-history.com/#fly8888/cursor_machine_id&Area)

## 免责声明

本工具仅供学习和研究使用。使用本工具可能违反 Cursor 的服务条款，请谨慎使用并自行承担相关风险。作者不对使用本工具导致的任何问题负责。

## License

MIT License
