# PrintDCP
Automates the process of creating DCP drives in their native environment.

## Requirements
- Any PC or Mac you have kicking around
- Ubuntu Desktop 16.04, 18.04 (don't bother with dual-boot)
- Source DCP Package Folder (on harddrive or network)
- Destination Drive (CRU hotswap, usb external, usb thumb)

## Installation
1. Download this Ubuntu Snap (coming soon)
2. Follow the instructions to install

## Advanced
Setup
```sudo git clone https://github.com/jeffbillings/PrintDCP.git PrintDCP
sudo chown -R $user:$group PrintDCP
sudo cp PrintDCP/printDCP /usr/bin```

Usage
```sudo printDCP [volume name] [source path] [drive device path]
sudo printDCP "DCP001" /media/externalHD/DCP_Folder /dev/sdb```

## License
GNU General Public License v3

---

©2018 Jeff Billings.
