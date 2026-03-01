# Cloudflare IP Data (cfdata)

一个基于 Go 语言开发的 Cloudflare IP 优选工具网页版。通过可视化的方式，帮助用户在不同网络环境下快速寻找并测试连接速度最快的 Cloudflare IP 地址。

## 🌟 主要功能

- **多平台支持**：提供 Windows, macOS, Linux, Android (Termux), MIPS 等多种架构的预编译二进制文件。
- **自动化扫描**：内置 Cloudflare IPv4 和 IPv6 地址库，支持一键并发扫描。
- **实时延迟测试**：通过 TCP 测试获取最真实的连接延迟。
- **深度测速**：支持对特定 IP 进行实际下载速度测试。
- **地理位置识别**：自动匹配 Cloudflare 数据中心 iata 代码，显示对应的城市和地区。
- **自托管 Web UI**：采用 WebSockets 技术，扫描结果实时推送，无需手动刷新。

## 🚀 快速开始

### 方式一：使用预编译二进制文件（推荐）

1. 进入 `cfdata-web` 目录。
2. 找到对应你操作系统的文件（例如 macOS 苹果芯片选择 `cfdata-darwin-arm64`）。
3. 赋予执行权限并运行：
   ```bash
   chmod +x cfdata-darwin-arm64
   ./cfdata-darwin-arm64
   ```
4. 在浏览器中访问：`http://localhost:13335`

### 方式二：从源码运行（需安装 Go）

```bash
# 克隆仓库后进入目录
go run cfdata.go
```

## 🛠 命令行参数

程序支持以下可选参数：

- `-port`: 设置 Web 服务的监听端口（默认 `13335`）。
- `-url`: 设置测速时使用的下载地址（默认使用 Cloudflare 官方测速接口）。

示例：
```bash
./cfdata -port 8080 -url speed.cloudflare.com/__down?bytes=50000000
```

## 📂 项目结构

- `cfdata.go`: 后端核心代码，处理扫描逻辑、测速及 WebSocket 通信。
- `index.html`: 嵌入式前端页面，包含完整的 UI 和交互逻辑。
- `cfdata-web/`:
    - `locations.json`: Cloudflare 数据中心位置数据库。
    - `ips-v4.txt` / `ips-v6.txt`: 待扫描的 IP 列表。
    - `cfdata-*`: 各平台预编译好的可执行文件。

## 💡 开发说明

- 本项目使用 `go:embed` 将前端 `index.html` 直接打包进二进制文件，实现单文件分发。
- 前端使用原生 JavaScript 和 CSS，不依赖沉重的框架，保持轻量。
- 并发扫描逻辑在后端由 Goroutines 实现，保证了极高的扫描效率。

## 📝 免责声明

本工具仅供学习和网络测试使用，请勿用于任何违反相关法律法规的活动。
