#!/bin/sh

cat << 'EOF' >> /etc/pacman.conf
[chaotic-aur]
# USA
## By: GarudaLinux and Fosshost
Server = https://builds.garudalinux.org/repos/$repo/$arch
## By: LordKitsuna
Server = https://repo.kitsuna.net/$arch

# Netherlands
## By: Var Bhat and LiteServer
Server = https://chaotic.tn.dedyn.io/$arch

# Burgos, Spain
## By: JKANetwork
Server = https://repo.jkanetwork.com/repo/$repo/$arch

# Germany
## By: Nico
Server = https://chaotic.dr460nf1r3.me/repos/$repo/$arch
## By: ParanoidBangL
Server = http://chaotic.bangl.de/$repo/$arch

# Seoul, Korea
## By: Ryoichi <t.me/r377yx>
Server = https://mirror.maakpain.kro.kr/garuda/$repo/$arch

# lonewolf
Server = https://lonewolf.pedrohlc.com/chaotic-aur/$repo/$arch
EOF