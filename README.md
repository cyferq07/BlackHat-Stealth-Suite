# BlackHat Stealth Suite

### Advanced Modular Toolkit for RedHat/BlackHat Stealth, Anti-Forensic Automation & Dynamic Identity Rotation
#### For Rooted Termux/Android (OxygenOS 15+), Professional Operational Use

---

![RedHat/BlackHat Stealth Suite](assets/stealth-logo.png)

---

## Table of Contents

- [Introduction](#introduction)
- [Features Overview](#features-overview)
- [Architecture](#architecture)
    - [Script Modules](#script-modules)
    - [Security & Anti-Forensic Design](#security--anti-forensic-design)
    - [Compatibility](#compatibility)
- [Installation](#installation)
- [Usage Guide](#usage-guide)
    - [Quick Start](#quick-start)
    - [Main Operations](#main-operations)
    - [Advanced Power Flows](#advanced-power-flows)
    - [Script Reference](#script-reference)
- [Operational Security (OPSEC)](#operational-security-opsec)
- [Customization & Future Integration](#customization--future-integration)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer & Ethics](#disclaimer--ethics)

---

## Introduction

**BlackHat Stealth Suite** is a cutting-edge, modular command-line toolkit designed specifically for penetration testers, red teams, privacy advocates, and advanced opsec users seeking world-class anonymity, traffic cloaking, and anti-forensic capability on rooted Android devices via [Termux](https://termux.com/).

Leveraging system-level control of network stacks, Tor, Orbot, VPN, DNS, MAC spoofing, browser fingerprinting, proxychains, and relentless anti-forensic cleanup routines, this suite is engineered for real-world field deployments in the most demanding environments—while always maintaining robust, error-free operation.

---

## Features Overview

- **Browser Stealth Automation:** Rotates User-Agent, launches via Orbot/Tor proxies, automates web footprints (supports both command-line and Android GUI browsers).
- **Dynamic Identity Rotation:** Schedules or triggers IP, MAC, DNS, User-Agent, and telemetry switches.
- **DNS Chain & Spoofing:** Randomizes secure DNS system-wide, supports dnsspoof for selective app spoofing, and hosts file manipulation for fake network surface.
- **Proxychains Integration:** Autodetects Tor/Orbot ports, generates proxychains config, supports chaining multiple proxy layers.
- **Orbot VPN Automation:** Orchestrates Orbot lifecycle, integrates with Apps VPN mode for system-wide Tor routing, broadcasts status for failover recovery.
- **MAC Spoofing:** Changes cellular MAC using cryptographically strong randomization, compatible with all main Android/Qualcomm modems/interfaces.
- **RAM-Only Logging & Aggressive Anti-Forensic Wipe:** No persistent logs, all traces wiped aggressively upon exit or detected tamper.
- **Timed & Event-Based Autopilot:** Master automation script rotates every feature continuously, using randomized intervals or triggers.
- **No Reboot, No Brick:** All modifications only touch user and networking layers; strict checks prevent any system instability.
- **Professional Error Handling:** Every script robustly traps errors, checks dependencies, and logs every action for operator review.

---

## Architecture

### Script Modules

- **`install.sh`**: Dependency installer for Termux/Android, validates root, error-free.
- **`cyfer_blackhat_ghost_tor_elite.sh`**: Main shell orchestrator (core stealth, Tor, MAC/IP management, anti-forensic).
- **`orbot_control.sh`**: Orbot Tor controller (start/stop/status via Android API, Apps VPN, API calls).
- **`proxychain_setup.sh`**: Proxychains config generator (auto sync SOCKS5/Control ports).
- **`mac_spoof.sh`**: Hardware MAC address randomizer for mobile data devices.
- **`dns_chain.sh`**: DNS rotation, hosts file edit, dnsspoof trigger.
- **`browser_stealth.sh`**: User-Agent randomizer, browser launcher (intent/cmd).
- **`dynamic_rotation.sh`**: Scheduled or event-triggered autocycling (IP/MAC/DNS/UA).
- **`blackops_final_autopilot.sh`**: Ultimate “one launcher to rule them all” automation wrapper.
- **`requirements.txt`**: Python module dependencies (support for automation/scripts).
- **`.gitignore`**: Cleans logs/temp/cache from repo.
- **Scripts Folder (`/scripts`)**: For future integrations.

### Security & Anti-Forensic Design

- **RAM-only logging:** No log files on disk except encrypted/cached RAM; wiped after operaton.
- **Cleanup traps:** Every exit/int/SIGTERM wipes all session traces (history, RAM logs, system logs, temp files).
- **Error catch/fail-safe:** No commands lead to device reboot, shutdown, or brick—guarded at every layer.
- **No default ports/scans:** Every SOCKS/TCP/UDP/VPN port is randomized each start.

### Compatibility

- Android 10+ (OxygenOS 15, MIUI, Pixel, Samsung, etc—root required)
- Termux (latest from F-Droid recommended)
- Magisk for root (must grant Termux SU permission)
- Orbot/Guardian Project (Play/F-Droid Apps VPN mode)
- Busybox (recommended for some advanced net commands)

---

## Installation

1. Clone or download the repo:
   ```bash
   git clone https://github.com/<your-user>/blackhat-stealth-suite.git
   cd blackhat-stealth-suite
   ```

2. Install dependencies (Termux/Android):
   ```bash
   bash install.sh
   ```

3. (Optional) Configure Orbot:
   - Install Orbot via Play Store or F-Droid.
   - Enable "Apps VPN" mode, allow local API access if automating.

---

## Usage Guide

### Quick Start

- **Full automation (all features):**
  ```bash
  bash blackops_final_autopilot.sh
  ```

- **Dependency check:**
  ```bash
  bash install.sh
  ```

- **Launch browser in stealth (random UA/proxy):**
  ```bash
  bash browser_stealth.sh https://ipinfo.io/
  ```

### Main Operations

- **Rotate identity/IP/MAC/DNS every 120 seconds, 10 rounds:**
  ```bash
  bash dynamic_rotation.sh 120 10
  ```

- **Change MAC for cellular/wwan:**
  ```bash
  bash mac_spoof.sh
  ```

- **Setup proxychains for Tor/Orbot:**
  ```bash
  bash proxychain_setup.sh
  ```

- **Control Orbot Tor VPN:**
  ```bash
  bash orbot_control.sh start
  bash orbot_control.sh stop
  bash orbot_control.sh status
  bash orbot_control.sh proxychains
  ```

### Advanced Power Flows

- **DNS chain + spoof (real-time):**
  ```bash
  bash dns_chain.sh
  ```

- **Master launcher (timed autopilot, browser & proxy, MAC/IP/DNS sync, cleanup trap):**
  ```bash
  bash blackops_final_autopilot.sh
  ```

### Script Reference

| Script                        | Functionality                                            |
|-------------------------------|---------------------------------------------------------|
| install.sh                    | Dependency bootstrap for Termux/Android                 |
| cyfer_blackhat_ghost_tor_elite.sh | Core shell: stealth ops, Tor, MAC/IP, cleanup         |
| orbot_control.sh              | Orbot Tor controller via Android API                    |
| proxychain_setup.sh           | Proxychains config automation                           |
| mac_spoof.sh                  | MAC address randomizer                                  |
| dns_chain.sh                  | DNS randomization/spoof                                 |
| browser_stealth.sh            | Browser automation (intent, UA randomization)           |
| dynamic_rotation.sh           | Timed IP/MAC/DNS/UA autocycler                          |
| blackops_final_autopilot.sh   | Master automation (all in one/continuous)               |
| requirements.txt              | Python modules (for scripting, opt)                     |
| .gitignore                    | Cleans logs/temp/cache                                  |

---

## Operational Security (OPSEC)

- Designed with "Red Team" and operational privacy as highest priority.
- All settings, logs, and temp files wiped—RAM only.
- Modular so you can split into submodules for custom flows.
- Defensive checks prevent accidental reboot, lock, or brick.
- Script errors gracefully handled, dependency checks automated.

---

## Customization & Future Integration

- Easily add **WireGuard/OpenVPN** config scripts for additional VPN hops.
- Extend fingerprint randomization (Android props, IDs, WebGL, sensors).
- Build custom API/data exfil modules (OnionShare, headless Chrome, etc).
- Integrate live threat feeds for auto-block/auto-rotate (Firehol, Alienvault).
- Add your own detection patterns or rotation triggers (signal drop, cell change, app event).
- Place all future scripts in `/scripts` directory.

---

## Contributing

Contributions are welcome! Please fork, propose pull requests, or open issues with new ideas, improvements, or field reports.  
Feel free to suggest enhancements for new modules, better error trapping, or integrations with additional pentest or privacy tools.

---

## License

**MIT License**—see [LICENSE](LICENSE) for details.  
Designed for research, legal, defensive, and red team use only.

---

## Disclaimer & Ethics

This project is intended solely for ethical, legal, and academic research in privacy, security, and operational defense.  
Usage for unauthorized intrusion, harm, or adversarial activity is strictly forbidden.

_DEV: cyferq07 / RedHat-elite / BlackHat Crew_

---
