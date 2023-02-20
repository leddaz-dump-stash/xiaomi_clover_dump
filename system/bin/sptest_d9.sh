#!/system/bin/sh

cd /system/bin
testcmd="./factorytest -t 25 -l /system/etc/tas2557_stereo_TAS2557.ftcfg -r /system/etc/tas2557_stereo_TAS2557-B.ftcfg -v"
resultfile="/persist/smartpa_test.txt"
datafile="/persist/sp_result.txt"

getresultA()
{
    cat $resultfile | grep "SPK A calibration success!" | wc -l
}
getresultB()
{
    cat $resultfile | grep "SPK B calibration success!" | wc -l
}

#Delete old result files
rm -rf $resultfile
rm -rf $datafile

#Smart pa, set program 0
tinymix 'Stereo Program' 0
#Smart pa, set config 2:music mode
tinymix 'Stereo Configuration' 2
sleep 1

#Test start
$testcmd > $resultfile
chmod 666 $resultfile
sleep 2

if [ `getresultA` = "1" ]; then
setprop sys.spA.result pass
else
setprop sys.spA.result fail
fi

if [ `getresultB` = "1" ]; then
setprop sys.spB.result pass
else
setprop sys.spB.result fail
fi

#Load calibration data if both pass
if [ `getresultA` = "1" -a `getresultB` = "1" ]; then
	echo "calibration pass, set into drv"
	tinymix 'Stereo Calibration' 255
else
	echo "calibration fail, do nothing"
fi

#Smart pa, set config 0
tinymix 'Stereo Configuration' 0

touch $datafile
chmod 666 $datafile
echo `cat $resultfile | grep "DevA Re"` > $datafile
echo `cat $resultfile | grep "DevB Re"` >> $datafile
