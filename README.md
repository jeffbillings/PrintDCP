## Introduction
This script automates the process of initializing DCP drives and copying DCPs.

## Requirements
- Ubuntu Desktop 18.04 LTS
- DCP Package Folder (on harddrive or network)
- Destination Drive (CRU hotswap, usb external, usb thumb)

## Installation
```
*Clone the repository*
sudo git clone https://github.com/jeffbillings/PrintDCP.git PrintDCP

*Set permissions to local user*
sudo chown -R $user:$group PrintDCP

```

## Desktop Usage
*Initialize DCP Drive*
Double-click "1) Prepare Drive"

*Copy DCP to Drive*
Double-click "2) Copy DCP"

## Terminal Usage
```
*Usage instructions*
./PrintDCP -h

*Initialize DCP Drive*
./PrintDCP -i

*Copy DCP to Drive*
./PrintDCP -p
```

## License
GNU General Public License v3

---

©2018 Jeff Billings.
