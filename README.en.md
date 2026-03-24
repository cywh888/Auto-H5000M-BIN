# 🚀 ImmortalWrt H5000M Auto Build

> 🌐 Language / 语言：[简体中文](README.md) | **English**

**Auto-H5000M-BIN**: Automated firmware build workflow for ImmortalWrt on H5000M, with plugin management and upstream source update checking.

[![Build ImmortalWrt H5000M](https://github.com/shi-an/Auto-H5000M-BIN/actions/workflows/build.yml/badge.svg)](https://github.com/shi-an/Auto-H5000M-BIN/actions/workflows/build.yml)

Built from [padavanonly/immortalwrt-mt798x-24.10](https://github.com/padavanonly/immortalwrt-mt798x-24.10), branch [`mt798x-mt799x-6.6-mtwifi`](https://github.com/padavanonly/immortalwrt-mt798x-24.10/tree/mt798x-mt799x-6.6-mtwifi).

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

> **Web UI Language**: LuCI supports English. Go to *System → System → Language and Style → Language → English* to switch.

---

## 🛠️ Hardware Acceleration

This firmware is built on the dedicated MT798x/MT799x kernel tree, which includes:

- **MediaTek WED** (Wireless Ethernet Dispatch) — included via upstream platform support
- **MediaTek HNAT** (Hardware NAT) — included via upstream platform support
- **TurboACC-MTK** — optional MTK hardware acceleration (selectable at build time)
- **EQoS-MTK** — optional MTK traffic QoS (selectable at build time)

> When neither TurboACC nor EQoS is selected, **BBR** congestion control is enabled by default (`net.ipv4.tcp_congestion_control=bbr`).

---

## 📦 Plugins

### 🎯 Pre-installed

| Plugin | Description |
|--------|-------------|
| Argon Theme | Modern LuCI theme |
| Airpifanctrl | Fan speed control |
| RamFree | Memory release utility |
| AutoReboot | Scheduled reboot |
| ttyd | Web-based terminal |

### 📋 Optional (selectable at build time)

#### 🌐 Network

| Plugin | Description |
|--------|-------------|
| TurboACC-MTK | MTK hardware acceleration |
| EQoS-MTK | MTK traffic QoS |
| QModem | 5G/LTE modem management (Quectel, Fibocom, etc.) |
| QModem Next | QModem next-generation version |
| AT WebServer | AT command web interface for 5G modems |
| HomeProxy | Multi-protocol modern proxy |
| OpenClash | Clash-based proxy client (kernel pre-installed) |
| Nikki | Transparent proxy tool |
| MWAN3 | Multi-WAN load balancing |
| UPnP | Automatic port mapping |
| ZeroTier | Virtual LAN |
| EasyTier | Decentralized mesh networking |
| Lucky | Network toolbox |
| WireGuard | WireGuard VPN |
| WatchCat | Network watchdog and auto-restart |
| NetSpeedTest | Network speed test |

#### 🛡️ System

| Plugin | Description |
|--------|-------------|
| AdGuardHome | Ad blocking & DNS |
| Adbyby Plus | Ad filtering |
| MosDNS | Modern DNS server |
| Vlmcsd | KMS activation server |
| DockerMan | Docker management |
| Bandix | Network traffic analysis |
| EtherWake | Wake-on-LAN |
| Daed | eBPF-based transparent proxy |

---

## ⏰ Build Workflows

| Workflow | Purpose |
|----------|---------|
| `build.yml` | H5000M release build — published as latest Release |
| `build-pre.yml` | MT798x pre-release / test build |
| `update-checker.yml` | Monitors upstream source for updates |

### 📝 Notes

- **Plugin config memory**: The system saves your last plugin selection. The next build will use the same configuration by default.
- **Upstream sync**: The update checker periodically monitors the upstream source repo and triggers a rebuild when new commits are detected.

---

## 🔗 Related Links

- [Upstream Source](https://github.com/padavanonly/immortalwrt-mt798x-24.10)
- [QModem Project](https://github.com/FUjr/QModem)
- [OpenWrt-nikki](https://github.com/nikkinikki-org/OpenWrt-nikki)
- [ImmortalWrt Official](https://immortalwrt.org/)

---

## 📝 License

This project follows the licenses of the upstream projects it is based on.
