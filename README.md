# NixOS Flake Configurations

Declarative multi-host NixOS and Home Manager setups powered by Flakes, Plasma Manager, and Cachix.

---

## 🖥️ Hosts

| Host | Type | Desktop / Flavor | Keyboard Layout |
| :--- | :--- | :--- | :--- |
| **ThinkPad** | Laptop | KDE Plasma (Dark / Ice / Blue) | US (Colemak) |
| **IdeaCentre** | Desktop | KDE Plasma (Light / Classic / Pink) | Latam |
| **IdeaPad** | Laptop | KDE Plasma (Dark / Ice / Pink) | Latam |
| **Pavilion** | Laptop | KDE Plasma (Light / Classic / Pink) | Latam |

---

## 📦 Binary Cache

Pre-built binaries are hosted via [Cachix](https://cachix.org):

* **Cache URL:** `https://gbngnlez.cachix.org`
* **Public Key:** `gbngnlez.cachix.org-1:4087tPR0DCehBmp1z8gmoRk91VcUOjmcV9KdKI64MOU=`

To manually use this cache:

```bash
cachix use gbngnlez