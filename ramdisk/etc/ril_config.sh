#!/vendor/bin/sh

cat /efs/factory.prop | while read line
do
    setprop `echo $line | sed 's/=/ /'`
done
