
####################################################################################################
##                                  FERNWOOD PENETRATION SUITE V1                                 ##
##                    ###########   ###########   ###########   ####        ##                    ##
##                    ##            ##            ##       ##   ## ##       ##                    ##
##                    ##            ##            ##       ##   ##  ##      ##                    ##
##                    ##            ##            ##       ##   ##   ##     ##                    ##
##                    #######       #######       ###########   ##    ##    ##                    ##
##                    ##            ##            ##     ##     ##     ##   ##                    ##
##                    ##            ##            ##      ##    ##      ##  ##                    ##
##                    ##            ############  ##        ##  ##        ####                    ##
##                                                                                                ##
####################################################################################################
##### MASTER-INSTALLER ##### KALI LINUX OS ##### BY: MATT FERLAINO ##### PENETRATION SINCE '17 #####
####################################################################################################

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "********************************"
	echo "This script must be ran as root!"
	echo "********************************"
	exit 1
fi

# Setting Permissions/Ownership
echo dir=$(pwd)
echo ""
echo "********************************"
echo "Setting permissions/ownership..."
echo "********************************"
cd ~
chown root "$dir/Master-Installer.sh"
chmod 777 "$dir/Master-Installer.sh"

# Download Updates
echo ""
echo "***********************************"
echo "Downloading first set of updates..."
echo "***********************************"
apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade

# Clean
echo ""
echo "*****************************"
echo "Cleaning old archive files..."
echo "*****************************"
apt-get -y autoclean

# Autoremove
echo ""
echo "***************"
echo "Autoremoving..."
echo "***************"
apt-get -y autoremove

# Download/Install Tor Software
echo ""
echo "******************"
echo "Downloading Tor..."
echo "******************"
apt-get -y install tor

# Download/Install SSH
echo ""
echo "*****************"
echo "Installing SSH..."
echo "*****************"
apt-get -y install openssh-server
update-rc.d -f ssh remove
update-rc.d -f ssh defaults

# Make a new directory
echo ""
echo "*******************"
echo "Making directory..."
echo "*******************"
cd /etc/ssh/
mkdir insecure_old
mv ssh_host* insecure_old
dpkg-reconfigure openssh-server

echo ""
echo "******************"
echo "Generating keys..."
echo "******************"
# Generate new keys
cat <<EOT >> sshd_config
#	$OpenBSD: sshd_config,v 1.101 2017/03/14 07:19:07 djm Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

#Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#SyslogFacility AUTH
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
PermitRootLogin yes
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

#PubkeyAuthentication yes

# Expect .ssh/authorized_keys2 to be disregarded by default in future.
#AuthorizedKeysFile	.ssh/authorized_keys .ssh/authorized_keys2

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
#IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication yes
PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no

# GSSAPI options
#GSSAPIAuthentication no
#GSSAPICleanupCredentials yes
#GSSAPIStrictAcceptorCheck yes
#GSSAPIKeyExchange no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of ""PermitRootLogin without-password"".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
UsePAM yes

#AllowAgentForwarding yes
#AllowTcpForwarding yes
#GatewayPorts no
X11Forwarding yes
#X11DisplayOffset 10
#X11UseLocalhost yes
#PermitTTY yes
PrintMotd no
#PrintLastLog yes
#TCPKeepAlive yes
#UseLogin no
#PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#UseDNS no
#PidFile /var/run/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# Allow client to pass locale environment variables
AcceptEnv LANG LC_*

# override default of no subsystems
Subsystem	sftp	/usr/lib/openssh/sftp-server

# Example of overriding settings on a per-user basis
#Match User anoncvs
#	X11Forwarding no
#	AllowTcpForwarding no
#	PermitTTY no
#	ForceCommand cvs server
EOT

# Restart the service
echo ""
echo "*************************"
echo "Restarting the service..."
echo "*************************"
sudo service ssh restart
update-rc.d -f ssh enable 2 3 4 5
sudo service ssh status

# Move to the desktop directory
cd $dir

# Clone the url
echo ""
echo "**************************"
echo "Dowloading the software..."
echo "**************************"
git clone https://github.com/Und3rf10w/kali-anonsurf

# Move into the file
cd kali-anonsurf

# Ensure it has the proper premissions
echo ""
echo "***********************"
echo "Ensuring Permissions..."
echo "***********************"
chmod 777 installer.sh

# Run the installer
echo ""
echo "**************************"
echo "Installing the software..."
echo "**************************"
./installer.sh run

# Install Komodo Edit
echo ""
echo "********************"
echo "Installing Komodo..."
echo "********************"
sudo add-apt-repository ppa:mystic-mirage/komodo-edit
sudo apt-get update
sudo apt-get install komodo-edit

# Install Chromium
echo ""
echo "******************************"
echo "Installing Chromium Browser..."
echo "******************************"
apt-get install -y chromium

# Install x11vnc
echo ""
echo "********************"
echo "Installing x11vnx..."
echo "********************"
apt-get -y install x11vnc

# Install Wine
echo ""
echo "******************"
echo "Installing Wine..."
echo "******************"
apt-get -y install wine

# Install Wine
echo ""
echo "*********************"
echo "Installing Sublime..."
echo "*********************"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get -y install sublime-text

# Create Desktop Links
cat <<EOT >> x11vnc.Desktop
[Desktop Entry]
Name=Start x11vnc
Comment=Start x11vnc
Exec=/usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /root/.vnc/passwd -rfbport 5900 -shared
Icon=applications-internet
Terminal=false
Type=Application
Name[en_US]=x11vnc
EOF

cat Chromium.desktop << EOF
[Desktop Entry]
Name=Chromium
Comment=Start Chromium
Exec=chromium --no-sandbox
Icon=applications-internet
Type=Application
EOT

# Copy Identity
cp -f /root/Desktop/Fern-Pen-Testing/Identity > /root/Desktop

# Downloading Final Set Of Updates
echo ""
echo "********************************"
echo "Installing Windows Powershell..."
echo "********************************"
apt update && apt -y install curl gnupg apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/powershell.list
apt update
apt -y install powershell

# Downloading Final Set Of Updates
echo ""
echo "***********************"
echo "Installing Wireguard..."
echo "***********************"
apt install wireguard resolvconf

# Public/Private key pair on server
wg genkey | tee privatekey | wg pubkey > publickey
umask u=rwx,go= && cat > /etc/wireguard/wg0.conf << EOF
[Interface]
Address = 10.222.222.1/24
SaveConfig = true
ListenPort = 51820
PrivateKey = -SERVER PRIVATE KEY-

[Peer]
PublicKey = -CLIENT PUBLIC KEY-
AllowedIPs = 10.222.222.2/32, 192.168.2.0/24
EOF

# Public/Private key pair on client
wg genkey | tee privatekey | wg pubkey > publickey
umask u=rwx,go= && cat /etc/wireguard/wg0.conf  << EOF
[Interface]
Address = 10.200.200.2/32
PrivateKey = -CLIENT PRIVATE KEY-
DNS = 8.8.8.8

[Peer]
PublicKey = -SERVER PUBLIC KEY-
Endpoint = public.ip.of.server:51820
AllowedIPs = 10.200.200.0/24
PersistentKeepalive = 21
EOF

# Enable Masquerade & IP Forwarding
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward

# Downloading Final Set Of Updates
echo ""
echo "***********************************"
echo "Downloading final set of updates..."
echo "***********************************"
apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade

# Exit
echo ""
echo "***************************************"
echo "----- Composite Computing Company -----"
echo "--- Supereme Architect of The Realm ---"
echo "--------- In Khellio We Trust ---------"
echo "***************************************"
