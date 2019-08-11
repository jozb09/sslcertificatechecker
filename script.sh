#!/bin/bash

#Jozb

input="/home/joz2hac/MyBash/certificate/domain.txt"
curyear=`date +%Y`
curmonth=`date +%m`
curdate=`date +%d`
while IFS= read -r line
do
echo "$line"
tuma=`echo | openssl s_client -servername "$line" -connect "$line":443 2>/dev/null | openssl x509 -noout -dates | grep notAfter | cut -d= -f2`
a=( $tuma )
fullDate=`echo ${a[0]}${a[1]}${a[3]}`

#Year Comparison.
year=`echo ${a[3]}`

if [ $curyear -gt $year ]; then
    echo "Certificate Expired"
fi
if [ $curyear -lt $year ]; then
    echo "Certificate not Expired"
fi
if [ $curyear -eq $year ]; then
   #Month Comparison.
    month=`echo ${a[0]}`

    month=( ["Jan"]=1 ["Feb"]=2 ["Mar"]=3 ["Apr"]=4 ["May"]=5 ["Jun"]=6 ["Jul"]=7 ["Aug"]=8 ["Sept"]=9 ["Oct"]=10 ["Nov"]=11 ["Dec"]=12)

    for i in "${month[@]}"
    do
        if [ $curmonth -lt $i ]; then
            echo "Certificate not expired"
        fi
        if [ $curmonth -gt $i ]; then
            echo "Certificate expired"
        fi
        if [ $curmonth -eq $i ]; then
            #Date comparison
            datee=`echo ${a[1]}`
            if [ $curdate -lt $datee ]; then
                echo "Certificate not Expired"
            fi
            if [ $curdate -gt $datee ]; then
                echo "Certificate Expired"
            fi 
        fi
    done    
fi

#echo $tuma 
done < "$input"
