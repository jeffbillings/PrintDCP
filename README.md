# PrintDCP
Automates the process of creating DCP drives in their native environment.

## Requirements
- Ubuntu Desktop 16.04, 18.04
- Source DCP Folder (on harddrive or network)
- Destination Drive (CRU hotswap, usb external, usb thumb)

## Installation
```
sudo git clone https://github.com/jeffbillings/PrintDCP.git PrintDCP
sudo cp PrintDCP/printDCP /usr/bin
```

## Usage
GUI
```
sudo printDCP -g
```

Terminal
```
sudo printDCP [source folder path] [drive device path]
```

## License
GNU General Public License v3

---

©2018 Jeff Billings.
