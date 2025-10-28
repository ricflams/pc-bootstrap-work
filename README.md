# 🧰 Bootstrap Repo

A pragmatic, reproducible workstation setup for Windows with:

* **winget** (CLI) + optional **WingetUI** (GUI)
* **export/importable package manifest**
* **append‑only notes/logging** for manual steps
* **Dev Container / Docker** image for low‑effort, containerized installs of CLI/dev tooling

---

## 🚀 Quick Start (Fresh Windows PC)

This repo lets you bring a new Windows PC to your personal baseline with minimal steps.

### 1. Install Git

```powershell
winget install --id Git.Git -e --source winget
```

Then open a new terminal to let git's path take effect.

### 2. Configure Git

```powershell
git config --global user.name "Richard Flamsholt"
git config --global user.email "richard@flamsholt.dk"
git config --global credential.helper manager
git config --global init.defaultBranch main
git config --global pull.rebase false
```

### 3. Clone the repo

```powershell
mkdir C:/Repos/ricflams
cd C:/Repos/ricflams
git clone https://github.com/ricflams/pc-bootstrap-work.git pc-bootstrap-work
cd pc-bootstrap-work\bootstrap
```

From here you can run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\setup.ps1
```

---

## 📁 Repository Structure

```
pc-bootstrap-work/
├─ README.md
├─ notes/
│  └─ MACHINE_NOTES.md
├─ manifests/
│  ├─ winget-packages.json         # exported/imported by winget/WingetUI
│  └─ apt-packages.txt             # optional: baseline apt packages for dev container/WSL
├─ bootstrap/
│  ├─ setup.ps1                    # first-run script on a fresh Windows machine
│  ├─ export-state.ps1             # periodic export of current state (inventories)
│  ├─ notes.ps1                    # lightweight logging helpers + profile hook
│  └─ schedule-export.ps1          # optional: schedule monthly state export
├─ wsl/
│  └─ bootstrap.sh                 # optional: WSL/Ubuntu post-install provisioning
└─ .devcontainer/
   ├─ devcontainer.json
   └─ Dockerfile
```

---

## 🧰 Helpful manual steps if needed

### Installing winget

On modern Windows, winget should already be available. If not:

1. Open Microsoft Store → search **“App Installer”** → install or update it.
2. Reboot or open a new terminal.

### Resetting Git credentials

If you need to reset stored credentials:

* Open **Control Panel → Credential Manager → Windows Credentials** and remove entries like `git:https://github.com`
* Or run:

```powershell
cmdkey /list | findstr git
cmdkey /delete:git:https://github.com
```

The next Git operation will prompt GCM again.

### Manual Git install

If winget is not available, you can also download Git from:
[https://git-scm.com/download/win](https://git-scm.com/download/win)

---

## 🛠 Maintenance

* Periodically export state:

  ```powershell
  .\bootstrap\export-state.ps1
  ```

  Commit the generated files under `state/`.

* (Optional) schedule monthly exports:

  ```powershell
  .\bootstrap\schedule-export.ps1
  ```

## ♻️ Reinstall on a new machine

* Install Git and clone this repo.
* Run `bootstrap/setup.ps1` or import `manifests/winget-packages.json` via WingetUI.
* Reapply any items noted in `notes/MACHINE_NOTES.md`.
