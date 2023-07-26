# Vajra EDR Tool
![Image](https://getvajra.com/static/media/vajralogo.b2efeacf3b8d1ac36fd5a25bc9ea1e21.svg)

vajra-client is the Vajra EDR client installation repository

## About

According to the fables in Indian mythologies, [Vajra](https://en.wikipedia.org/wiki/Vajra/) is one of the most powerful weapon in the entire universe and is used to defend against the forces intending to attack the institutions of 'dharma'. Project Vajra, an indegenously developed endpoint security system at IIT Bombay (an institute of national importance) embodies the characteristic of the celestial vajra to provide a set of high quality defensive and offensive capabilities against the growing and ever changing landscape of cyber threats in the country.

## Supported platforms
**Windows 32bit and 64bit**
1. Windows 7
2. Windows 8 and 8.1
3. Windows 10
4. Windows 11

**Linux {Kernel version >=4.18}**
1. Ubuntu
2. CentOS
3. RHEL
4. Fedora
5. Arch Linux
6. BOSS Linux


## Installation

### Windows
```python
Step 1. Download the vajra-client repository
Step 2. Unzip the folder
Step 3. Right click on Vajra_install.bat select "Run as Administrator"
Step 4. Done
```

### Linux
```python
Step 1. Download the vajra-client repository
Step 2. Unzip the folder
Step 3. Open the Terminal and locate the "vajrainstall.sh" file
Step 4. chmod +x vajrainstall.sh
Step 5. sudo ./vajrainstall.sh
Step 6. Done
```

## Uninstallation

### Windows
```python
Step 1. Download the vajra-client repository
Step 2. Unzip the folder
Step 3. Right click on Vajra_uninstall.bat select "Run as Administrator"
Step 4. Done
```

### Linux
```python
Step 1. Download the vajra-client repository
Step 2. Unzip the folder
Step 3. Open the Terminal and locate the "vajrainstall.sh" file
Step 4. chmod +x vajrainstall.sh
Step 5. sudo ./vajrainstall.sh -uninstall
Step 6. Done
```

## Troubleshooting

### Windows
```bash
### Node status is offline
1. Windows > services > vajra service. If service is stopped, restart the service
2. Windows > services > plgx_extension service. If service is stopped, restart the service
3. Check client`s network connectivity with server
```

### Linux
```bash
### Node status is offline
1. 'sudo systemctl status vajra.service' It should be in running mode
2. Check client`s network connectivity with server
```
## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Visit us

To see your systems protection status visit [Vajra](https://getvajra.com/).

For queries write us on [support](mailto:sablearjun@iitb.ac.in)

## Publications

[A. Sable, D. Sawant, S. Kahalekar and M. K. Hanawal, "Threat Detection and Response in Linux Endpoints," 2022 14th International Conference on COMmunication Systems & NETworkS (COMSNETS), Bangalore, India, 2022, pp. 447-449, doi: 10.1109/COMSNETS53615.2022.9668567.](https://ieeexplore.ieee.org/document/9668567)

[Y. C. Jadhav, A. Sable, M. Suresh and M. K. Hanawal, "Securing Containers: Honeypots for Analysing Container Attacks," 2023 15th International Conference on COMmunication Systems & NETworkS (COMSNETS), Bangalore, India, 2023, pp. 225-227, doi: 10.1109/COMSNETS56262.2023.10041276.](https://ieeexplore.ieee.org/abstract/document/10041276)

---
**Readme file for:** Vajra EDR Tool

**Owner:** Vajra EDR, Indian Institute of Technology, Bombay

**Update name:** 1.0.0.1

**Publication date:** 25 July 2023

**Last modified date:** 25 April 2023

----
Thanks

1. [Osquery](https://osquery.io)

2. [TCAAI](https://www.tcaai.iitb.ac.in)

3. [NCETIS](http://www.ee.iitb.ac.in/~ncetis/)
