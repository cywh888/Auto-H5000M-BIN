# 🚀 ImmortalWrt H5000M 自动编译

> 🌐 Language / 语言：**简体中文** | [English](README.en.md)

**Auto-H5000M-BIN**：ImmortalWrt H5000M 固件自动化构建工作流，支持插件管理与源码更新检查。

[![Build ImmortalWrt H5000M](https://github.com/shi-an/Auto-H5000M-BIN/actions/workflows/build.yml/badge.svg)](https://github.com/shi-an/Auto-H5000M-BIN/actions/workflows/build.yml)

基于 [padavanonly/immortalwrt-mt798x-24.10](https://github.com/padavanonly/immortalwrt-mt798x-24.10) 源码，分支 [`mt798x-mt799x-6.6-mtwifi`](https://github.com/padavanonly/immortalwrt-mt798x-24.10/tree/mt798x-mt799x-6.6-mtwifi)，自动编译 H5000M 路由器固件。

---

## 📥 下载固件

前往 [Releases](https://github.com/shi-an/Auto-H5000M-BIN/releases) 页面下载最新固件。

---

## 🔧 默认配置

| 项目               | 值                                     |
| ------------------ | -------------------------------------- |
| **访问地址** | `192.168.88.1` 或 `immortalwrt.lan` |
| **用户名**   | `root`                               |
| **密码**     | `admin`                              |

---

## 📦 插件分类

### 🎯 预装插件

- **TurboACC-MTK** - MTK 硬件加速
- **EQoS-MTK** - 网络流量控制
- **Airpifanctrl** - 风扇控制
- **Argon 主题** - 美化界面
- **RamFree** - 内存释放
- **AutoReboot** - 自动重启
- **ttyd** - 网页终端

### 📋 可选插件（需手动选择）

#### 🌐 网络管理

- **QModem** - 5G/LTE 模组管理（支持 Quectel、Fibocom 等）
- **QModem Next** - QModem 新版
- **HomeProxy** - 现代化多协议代理
- **OpenClash** - 代理客户端（预安装内核）
- **Nikki** - 透明代理工具
- **MWAN3** - 多 WAN 负载均衡
- **UPnP** - 自动端口映射
- **ZeroTier** - 虚拟局域网
- **EasyTier** - 去中心化组网
- **Lucky** - 网络工具箱

#### 🛡️ 系统工具

- **AdGuardHome** - 广告过滤 & DNS
- **Adbyby Plus** - 广告过滤
- **MosDNS** - 现代 DNS 服务器
- **Vlmcsd** - KMS 激活服务器
- **DockerMan** - Docker 管理
- **WatchCat** - 网络监控和自动重启
- **NetSpeedTest** - 网络测速
- **Bandix** - 网络流量分析
- **WRtBWMon** - 带宽监控

---

## ⏰ 编译计划

- **主发布 (build.yml)**：H5000M 正式版本构建，自动发布为 latest Release
- **测试构建 (build-pre.yml)**：MT798x 测试版本构建，发布为 pre-release

### 📝 编译说明

- **插件配置记忆**：系统会自动保存您上次选择的插件配置，下次编译时默认使用相同配置
- **源码更新检查**：定期检查上游源码仓库的更新，确保固件基于最新源码构建
- **多工作流支持**：提供多个构建工作流，满足不同的编译需求

---

## 🔗 相关链接

- [上游源码](https://github.com/padavanonly/immortalwrt-mt798x-24.10)
- [QModem 项目](https://github.com/FUjr/QModem)
- [OpenWrt-nikki](https://github.com/nikkinikki-org/OpenWrt-nikki)
- [ImmortalWrt 官网](https://immortalwrt.org/)
- [项目仓库](https://github.com/existyay/Auto-H5000M-BIN)

---

## 📝 许可证

本项目遵循上游项目许可证。
