# HW configuration file for lotus
# Touch FW loader
dev=/sys/bus/spi/devices/spi9.0
fw=ttsp_fw.hex
app_id=`cat  $dev/appid`
case `cat /data/ttsp_fw_update` in
        "in_progress") flags=-force ;;
        *) flags="" ;;
esac
case "$app_id" in
	"0x3030") flags=-force ;;
	*) echo $app_id > /data/ttsp_appid ;;
esac

echo "in_progress" > /data/ttsp_fw_update
cyttsp_fwloader -dev $dev -fw /system/etc/firmware/$fw $flags
echo "done" > /data/ttsp_fw_update

# Audio jack configuration
dev=/sys/devices/platform/simple_remote.0
echo 0,301,1901 > $dev/accessory_min_vals
echo 300,1900  > $dev/accessory_max_vals
echo 0,51,251,511,851 > $dev/button_min_vals
echo 50,250,510,850,5000  > $dev/button_max_vals

# ALS configuration
dev=/sys/bus/i2c/devices/2-0040/
echo 0x90=0x06 > $dev/debug
echo 0x91=0x40 > $dev/debug

# Proximity sensor configuration
dev=/sys/bus/i2c/devices/2-0054/
val_cycle=2
val_nburst=3
val_freq=2
val_threshold=2 #Default value
val_filter=0

echo $val_cycle > $dev/cycle    # Duration Cycle. Valid range is 0 - 3.
echo $val_nburst > $dev/nburst  # Numb er of pulses in burst. Valid range is 0 - 15.
echo $val_freq > $dev/freq      # Burst frequency. Valid range is 0 - 3.

if `ls /data/etc/threshold > /dev/null`; then
    cat /data/etc/threshold > $dev/threshold # Use value from calibration
    rm /data/etc/threshold # Remove temp file
else # No value from calibration, use default value
    echo $val_threshold > $dev/threshold # sensor threshold. Valid range is 0-15(0.12V-0.87V)
fi

if `ls /data/etc/filter > /dev/null`; then
    cat /data/etc/filter > $dev/filter # Use value from calibration
    rm /data/etc/filter # Remove temp file
else # No value from calibration, use default value
    echo $val_filter > $dev/filter  # RFilter. Valid range is 0 - 3.
fi

#XPE_Modules_BACKPORTED TO XPeria GO
insmod /system/lib/modules/axperiau_ondemandax.ko
insmod /system/lib/modules/axperiau_pegasusq.ko
insmod /system/lib/modules/axperiau_sio_iosched.ko
insmod /system/lib/modules/axperiau_smartass2.ko
insmod /system/lib/modules/axperiau_vr_iosched.ko
insmod /system/lib/modules/axperiau_lulzactiveq.ko
insmod /system/lib/modules/crespo.ko

# system preferences
echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
cur_min_file=/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
CUR_MIN=`cat $cur_min_file`
echo 100000 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
cur_min_file2=/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
CUR_MIN=`cat $cur_min_file2`
echo 100000 /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
dev=/system/lib/libpower.so > /time {0,1,4,9}
dev=/system/lib/libpowermanager /stamina {data/system/batterystats.bin }
cat=/sys/power/forze_sync
target=`prop.sys.exec.process.boot`


#BETA TEST

clear
ps | rm '/zram/{print "$block_size" $ "$440MB_free_system" "$5"/440"MB";}'
free_disk | '/disk/{print "$440"MB"$1":}'
clear 
ps | awk '/controlpanel/{print "$0"$4"$1"$5/90780"MB"$9"$6";}'
ps | awk '/settings/{print "$1"$2"$5"$5/90780"MB"$9"";}'
ps | awk '/app_/{print " "$2" "$5/10240"MB"$9" ";}'
free | awk '/Mem/{print "Free Memory : "$64/253 b MB"}'
if [ "$pid" -gt 5 ]; then
    echo "stop services" > /system/bin/app_process
    kill -9 $pid
    rm
else
    exit
fi
 
scal_gov_file=/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
CUR_GOV=`cat $scal_gov_file`
insmod /system/lib/modules/axperiau_ondemandax.ko
insmod /system/lib/modules/axperiau_pegasusq.ko
insmod /system/lib/modules/axperiau_sio_iosched.ko
insmod /system/lib/modules/axperiau_smartass2.ko
insmod /system/lib/modules/axperiau_vr_iosched.ko
insmod /system/lib/modules/axperiau_lulzactiveq.ko
insmod /system/lib/modules/crespo.ko
 
scal_gov_file2=/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
CUR_GOV=`cat $scal_gov_file2`
insmod /system/lib/modules/axperiau_ondemandax.ko
insmod /system/lib/modules/axperiau_pegasusq.ko
insmod /system/lib/modules/axperiau_sio_iosched.ko
insmod /system/lib/modules/axperiau_smartass2.ko
insmod /system/lib/modules/axperiau_vr_iosched.ko
insmod /system/lib/modules/axperiau_lulzactiveq.ko
insmod /system/lib/modules/crespo.ko

# Fix issue on charge executor
chmod u+s /system/bin/chargemon_XPE

exec /system/bin/runWidow
exec /system/bin/urandom_XPE
exec /system/bin/CPXPE #cp  u

