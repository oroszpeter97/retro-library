
echo "Some wine bullshit fix..."
cd "$WINEPREFIX/drive_c/$INSTALLED_GAME_DIR/"
sed --in-place 's/xdd\.dll../ddraw.dll/' Heroes3.exe
echo "Some wine bullshit fixed!"

echo "HD patching..."
wine "$MOUNT_POINT/HoMM3_HD_Latest_setup.exe"
echo "HD patched!"
