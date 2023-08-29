# displayTemps-Proxmox
This is a script that allows you to display the temps of your node in the summary module of Proxmox.

The script makes its own backup files, however make your one ones for security.

Run this:

cp /usr/share/perl5/PVE/API2/Nodes.pm /usr/share/perl5/PVE/API2/Nodes.pm.backup

cp /usr/share/pve-manager/js/pvemanagerlib.js /usr/share/pve-manager/js/pvemanagerlib.js.backup
