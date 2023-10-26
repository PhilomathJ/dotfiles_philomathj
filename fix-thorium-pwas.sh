# Fixes the Exec path in the PWA *.desktop file
sed -i 's/opt\/chromium\.org\/thorium\/thorium-browser/opt\/thorium-browser\/thorium-browser/' /home/jeremy/.local/share/applications/thorium-*
echo "All fixed"
