# displayTemps-Proxmox
This is a script that allows you to display the temps of your node in the summary module of Proxmox.

The original proyect is from Reddit r/homelab, Agreeable-Clue83 it's the mind behind it.

The script makes its own backup files, however make your one ones for security.

Run this:

cp /usr/share/perl5/PVE/API2/Nodes.pm /usr/share/perl5/PVE/API2/Nodes.pm.backup

cp /usr/share/pve-manager/js/pvemanagerlib.js /usr/share/pve-manager/js/pvemanagerlib.js.backup

Use Bash Shell to run the script.

1. Give permissions (chmod u+x ./temps.sh)
2. Run the script ( ./yourOwnRute/temps.sh)

USER MANUAL

You can use this sensors names:

1. Composite
2. Sensor X (Put the number in the X)
3. Or any other that shows the sensor format: temperature

