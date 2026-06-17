#!/bin/bash

to="$1"
subject="$2"
message="$3"

trigger_ok=`echo "$message" | grep "Status" | grep "OK" | wc -l`
trigger_problem=`echo "$message" | grep "Trigger status" | grep "PROBLEM" | wc -l`
warning=`echo "$message" | grep "Trigger severity" | grep "Warning" | wc -l`
average=`echo "$message" | grep "Trigger severity" | grep "Average" | wc -l`
high=`echo "$message" | grep "Trigger severity" | grep "High" | wc -l`
disaster=`echo "$message" | grep "Trigger severity" | grep "Disaster" | wc -l`

if [ $trigger_ok -eq 0 -a $trigger_problem -eq 1 -a $warning -eq 1 -a $average -eq 0 -a $high -eq 0 -a $disaster -eq 0 ]
 then
  echo WARNING
  subject="%E2%9A%A0 ${subject}"
  #message="\`${message}\`"
elif [ $trigger_ok -eq 0 -a $trigger_problem -eq 1 -a $warning -eq 0 -a $average -eq 1 -a $high -eq 0 -a $disaster -eq 0 ]
 then
  echo AVERAGE
  subject="%F0%9F%94%B4 $subject"
  #message="*$message*"
elif [ $trigger_ok -eq 0 -a $trigger_problem -eq 1 -a $warning -eq 0 -a $average -eq 0 -a $high -eq 1 -a $disaster -eq 0 ]
  then
  echo HIGH
  subject="%F0%9F%94%B4 $subject"
  #message="*$message*"
elif [ $trigger_ok -eq 0 -a $trigger_problem -eq 1 -a $warning -eq 0 -a $average -eq 0 -a $high -eq 0 -a $disaster -eq 1 ]
  then
  echo DISASTER
  subject="%F0%9F%86%98 ${subject}"
  #message="`${message}`"
elif [ $trigger_ok -eq 1 ]
  then
  echo OK
  subject="%E2%9C%85 $subject"
else
  echo Undefine
  #subject="%E2%9D%93 $subject"
  subject="%F0%9F%94%B4 $subject"
fi

# Telegram API
KEY="{TOKEN}"
TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"

curl -x "" -s --max-time $TIMEOUT -d "chat_id=$to&disable_web_page_preview=1&text=$subject $message" "$URL" >/dev/null
