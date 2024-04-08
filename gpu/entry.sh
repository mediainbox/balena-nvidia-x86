

## Disable all display elements that could prevent removal of nouveau module
# Stop plymouth service used for splash screen display
DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket dbus-send \
    --system --dest=org.freedesktop.systemd1 --type=method_call --print-reply \
    /org/freedesktop/systemd1   org.freedesktop.systemd1.Manager.StartUnit \
    string:"plymouth-quit.service" string:"replace"

# Remove Nouveau modules
sleep 6
echo 0 > /sys/class/vtconsole/vtcon1/bind
sleep 2
rmmod nouveau
rmmod nvidiafb
sleep 2

# see https://forums.balena.io/t/blacklist-drivers-in-host-os/163437/25

# Insert Nvidia modules
insmod /nvidia/driver/nvidia.ko
insmod /nvidia/driver/nvidia-modeset.ko
insmod /nvidia/driver/nvidia-uvm.ko

/usr/bin/nvidia-smi
nvidia-modprobe

sleep infinity
