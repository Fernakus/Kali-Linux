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
##### KOMODO-INSTALLER ##### KALI LINUX OS ##### BY: MATT FERLAINO ##### PENETRATION SINCE '17 #####
####################################################################################################

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "-------------------------------"
	echo "This script must be ran as root"
	echo "-------------------------------"
	exit 1
fi

# Install Komodo Edit
echo "-----------------"
echo "Installing Komodo"
echo "-----------------"
sudo add-apt-repository ppa:mystic-mirage/komodo-edit
sudo apt-get update
sudo apt-get install komodo-edit

# Exit
echo "----------------------------"
echo "Fernwood.Penetration.Testing"
echo "----------------------------"


