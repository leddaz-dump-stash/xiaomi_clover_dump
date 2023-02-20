#!/system/bin/sh

cd /system/bin
testcmd="./gsort --check"
resultfile="/persist/gsort_test.txt"

#Delete old result files
rm -rf $resultfile

#Test start
$testcmd > $resultfile
chmod 666 $resultfile
