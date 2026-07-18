echo "Cracking game..."
cp "$MOUNT_POINT/NFSMW_Crack_1.3/"* "$WINEPREFIX/drive_c/$INSTALLED_GAME_DIR/"
echo "Cracking finished!"

echo "Patching widescreen fix..."
cp -r "$MOUNT_POINT/NFSMW_WidescreenFix/"* "$WINEPREFIX/drive_c/$INSTALLED_GAME_DIR/"
echo "Patching finished!"
