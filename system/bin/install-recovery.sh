#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:51778894:a75f88553837127afa2b0ccec2558ad107a9f513; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:47371594:c44e4dc615caedf248db20d5f68397826ab26685 EMMC:/dev/block/bootdevice/by-name/recovery a75f88553837127afa2b0ccec2558ad107a9f513 51778894 c44e4dc615caedf248db20d5f68397826ab26685:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
