# Fixes the Exec path in the Thorium PWA *.desktop file
sed -i 's/opt\/chromium\.org\/thorium\/thorium-browser/opt\/thorium-browser\/thorium-browser/' /home/jeremy/.local/share/applications/thorium-*

# Fixes the Exec path in the brave-bin PWA *.desktop file
sed -i 's/opt\/brave-bin\/brave/usr\/bin\/brave/g' /home/jeremy/.local/share/applications/brave-*
echo "All fixed"
