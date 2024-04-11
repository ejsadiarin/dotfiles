---
tags:
  - Security
  - Wizardry
  - Networking
date: 2024-03-27T11:11
title: nmap Wizardry
---
<!-- 2024-03-27-1111 (March 27, 2024 11:11 AM) -->
	
# `nmap` Wizardry
- [nmap](https://nmap.org/) is a powerful network scanning tool that can be used for a variety of purposes. This guide will cover some of the more advanced features of nmap, including how to scan for specific services, detect operating systems, and more.

### STATE:
- "`open`" ports means the port is accessible and has application or service listening to it/behind it.
  - **NOTE THAT:** this is the goal of hackers and pentesters
  - **NOTE THAT:** can be useful to see what services are running on the target (for non-security purposes).
- "`closed`" ports means the port is accessible but has NO application or service listening to it/behind it.
  - **NOTE THAT:** an accessible port without a service has no security implications since without an application/service, no one is listening, accepting the incoming packets, and processing them.
- "`filtered`" ports means the port is not accessible due to firewall rules or other network restrictions. Cannot be probed further.
- "`unfiltered`" ports means the port is accessible but nmap cannot determine if it is open or closed. Best to probe further/keep the port in mind incase it "opens".
- "`open|filtered`" ports means nmap cannot determine if the port is open or filtered.
- "`closed|filtered`" ports means nmap cannot determine if the port is closed or filtered.

### Scanning Techniques:
- normal nmap scan that scans the top 1000 ports
  ```bash
  nmap <target-ip-or-hostname>
  ```
- multiple normal nmap scan that scans the top 1000 ports
  ```bash
  nmap <target-ip-or-hostname> <target-ip-or-hostname> <target-ip-or-hostname>
  ```
- range and selected scan
  ```bash
  # scan a range of IPs (1-254) on a specific subnet (192.168.7.x, 192.168.8.x, 192.168.9.x)
  nmap 192.168.7,8,9.1-254
  # scan a specific 254 IPs on a specific subnet (192.168.7.x)
  nmap 192.168.7.0/24 # the 0 here is redundant because of /24 CIDR notation
  ```
- verbose scan
  ```bash
  nmap -v <target-ip-or-hostname>
  # or more verbose
  nmap -vv <target-ip-or-hostname>
  ```
- scan all ports
  ```bash
  nmap -p- <target-ip-or-hostname>
  ```
- aggressive scan
  ```bash
  nmap -A <target-ip-or-hostname>
  ```
- 

# Resources
[see nmap cheat sheet](nmap-cheat-sheet-output.txt)
[Ethical Hacking Deep Dive: Metasploit, Nmap, and Advanced Techniques (41m:55s)](https://www.youtube.com/watch?v=Ft6tLATCIVQ)
[nmap Full Guide](https://www.youtube.com/watch?v=JHAMj2vN2oU)
