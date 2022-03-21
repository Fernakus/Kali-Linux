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
##### ANON-SURF-INSTALLER ##### KALI LINUX OS ##### BY: MATT FERLAINO ##### PENETRATION SINCE '17 ##
####################################################################################################

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "-------------------------------"
	echo "This script must be ran as root"
	echo "-------------------------------"
	exit 1
fi

# Move to the desktop directory
cd Desktop

# Clone the url
echo "-----------------------"
echo "Dowloading the software"
echo "-----------------------"
git clone https://github.com/Und3rf10w/kali-anonsurf

# Move into the file
cd kali-anonsurf

# Ensure it has the proper premissions
echo "--------------------"
echo "Ensuring Permissions"
echo "--------------------"
chmod 777 installer.sh

# Run the installer
echo "-----------------------"
echo "Installing the software"
echo "-----------------------"
./installer.sh run

# Run AnonSurf
echo "-------------------------"
echo "Anonsurf Install Complete"
echo "-------------------------"
anonsurf start
anonsurf myip

# Exit
echo "----------------------------"
echo "Fernwood.Penetration.Testing"
echo "----------------------------"
