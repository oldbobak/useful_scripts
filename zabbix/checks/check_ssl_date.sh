#!/bin/bash
# check ssl cert expiring date
# $1 - host address
#   usage:    ./check_ssl_date.sh hostname port
#   returns number of days before expiration date
#
#  vs@NS 20180814

if [ -z $1 ] ; then
  echo "Error: missing host"
  echo "  Usage: $0 hostname [port]"
  exit 1
else
  HOSTNAME=$1
fi
#HOSTNAME=ya.ru

if [ -z $2 ] ; then
  PORT="443"
else
  PORT="${2}"
fi

EXPIRING_DATE=` echo | openssl s_client -servername ${HOSTNAME} -connect ${HOSTNAME}:${PORT} 2>/dev/null | openssl x509 -noout -dates | gr
ep notAfter`

EXPIRED=`echo $EXPIRING_DATE | cut -d= -f2`
EXP=`date -d "${EXPIRED}" +%s`
NOW=`date +%s`
#echo $EXPIRED
#echo $EXP
#echo $NOW
#echo "Port:$PORT"

echo $( expr '(' ${EXP} - ${NOW} ')' / 86400  )
