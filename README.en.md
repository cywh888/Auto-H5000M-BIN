# 🚀 ImmortalWrt H5000M Auto Build

> 🌐 Language / 语言：[简体中文](README.md) | **English**

**Auto-H5000M-BIN**: Automated firmware build workflow for ImmortalWrt on H5000M, with plugin management and upstream source update checking.

[![Build ImmortalWrt H5000M](https://github.com/shi-an/Auto-H5000M-BIN/actions/workflows/build.yml/badge.svg)](https://github.com/shi-an/Auto-H5000M-BIN/actions/workflows/build.yml)

Built from [padavanonly/immortalwrt-mt798x-24.10](https://github.com/padavanonly/immortalwrt-mt798x-24.10), branch [`mt798x-mt799x-6.6-mtwifi`](https://github.com/padavanonly/immortalwrt-mt798x-24.10/tree/mt798x-mt799x-6.6-mtwifi), auto-compiling firmware for the H5000M router.

---

## 📥 Download

Go to the [Releases](https://github.com/shi-an/Auto-H5000M-BIN/releases) page to download the latest firmware.

---

## 🔧 Default Configuration

| Item | Value |
|------|-------|
| **Address** | `192.168.88.1` or `immortalwrt.lan` |
| **Username** | `root` |
| **Password** | `admin` |

---

## 📦 Plugins

### 🎯 Pre-installed

- **TurboACC-MTK** - MTK hardware acceleration
- **EQoS-MTK** - Network traffic control
- **Airpifanctrl** - Fan control
- **Argon Theme** - UI theme
- **RamFree** - Memory release
- **AutoReboot** - Scheduled reboot
- **ttyd** - Web terminal

### 📋 Optional (selectable at build time)

#### 🌐 Network

- **QModem** - 5G/LTE modem management (Quectel, Fibocom, etc.)
- **QModem Next** - QModem next-generation version
- **HomeProxy** - Multi-protocol modern proxy
- **OpenClash** - Clash-based proxy client (kernel pre-installed)
- **Nikki** - Transparent proxy tool
- **MWAN3** - Multi-WAN load balancing
- **UPnP** - Automatic port mapping
- **ZeroTier** - Virtual LAN
- **EasyTier** - Decentralized mesh networking
- **Lucky** - Network toolbox

#### 🛡️ System

- **AdGuardHome** - Ad blocking & DNS
- **Adbyby Plus** - Ad filtering
- **MosDNS** - Modern DNS server
- **Vlmcsd** - KMS activation server
- **DockerMan** - Docker management
- **WatchCat** - Network watchdog and auto-restart
- **NetSpeedTest** - Network speed test
- **Bandix** - Network traffic analysis

---

## ⏰ Build Schedule

- **Main release (build.yml)**: H5000M production build, auto-published as latest Release
- **Test build (build-pre.yml)**: MT798x test build, published as pre-release

### 📝 Notes

- **Plugin config memory**: The system automatically saves your last plugin selection and uses it as default for the next build
- **Upstream sync**: Periodically checks the upstream source repo for updates to ensure the firmware is built from the latest source
- **Multi-workflow support**: Multiple build workflows available for different build needs

---

## 🔗 Related Links

- [Upstream Source](https://github.com/padavanonly/immortalwrt-mt798x-24.10)
- [QModem Project](https://github.com/FUjr/QModem)
- [OpenWrt-nikki](https://github.com/nikkinikki-org/OpenWrt-nikki)
- [ImmortalWrt Official](https://immortalwrt.org/)
- [Project Repository](https://github.com/shi-an/Auto-H5000M-BIN)

---

## 📝 License

This project follows the licenses of the upstream projects it is based on.
