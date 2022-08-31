#!/bin/bash

EMAIL="logsight.testing.001@gmail.com"
PASSWORD="jeXbiw-foxsyw-vamgy2"

echo 'Get token and user ID'
JSON=$(curl -s -X POST "https://logsight.ai:443/api/v1/auth/login" \
  -H "accept: */*" -H "Content-Type: application/json" \
  -d "{ \"email\": \"$EMAIL\", \"password\": \"$PASSWORD\"}")
TOKEN=$(echo $JSON | jq -r '.token')
USERID=$(echo $JSON | jq -r '.user .userId')
echo 'TOKEN:' $TOKEN
echo 'USERID:' $USERID

echo 'Deleted user'
JSON=$(curl -s -X DELETE "https://logsight.ai:443/api/v1/users/$USERID" \
  -H "accept: */*" -H "Authorization: Bearer $TOKEN")
echo 'JSON:' $JSON

echo 'Create user'
JSON=$(curl -s -X POST "https://logsight.ai/api/v1/users" \
  -H "accept: */*" -H "Content-Type: application/json" \
  -d "{ \"email\": \"$EMAIL\", \"password\": \"$PASSWORD\"}")
echo 'JSON:' $JSON
USERID=$(echo $JSON | jq -r '.userId')
echo 'USERID:' $USERID

send_log () {
  LEVEL=$1
  LOG_MESSAGE=$2
  TAG_1=$3
  TAG_2=$4

  # Replace .00700 with .%3N to add milliseconds (does not work on macOS)
  DATE_WITH_TIME=`date "+%Y-%m-%dT%T.00700"`

  JSON=$(curl -s -X POST "https://logsight.ai/api/v1/logs" \
    -H "accept: */*" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" \
    -d "{
      \"tags\": {\"version\": \"$TAG_1\", \"region\": \"$TAG_2\"},
      \"logs\": [{
              \"level\": \"$LEVEL\",
              \"timestamp\": \"$DATE_WITH_TIME\",
              \"message\": \"$LOG_MESSAGE\"
          }] }")
  echo 'JSON:' $JSON
}

send_logs () {
  N=$1
  TAG_1=$2
  TAG_2=$3
  shift
  shift
  shift
  STATES=("$@")

  echo "STATES:" $STATES

  for j in {1..$N}
  do
     echo "Sending message block #$j"

     for i in "${STATES[@]}"
     do

       if [[ " ${i} " =~ "EL1" ]]; then
          send_log "ERROR" "Cannot connect to cache id: $j" $TAG_1 $TAG_2
       fi
       if [[ " ${i} " =~ "ES1" ]]; then
          send_log "INFO" "Failure to store customer data ($j)" $TAG_1 $TAG_2
       fi
       if [[ " ${i} " =~ "ELS1" ]]; then
          send_log "ERROR" "Failure to load customer data" $TAG_1 $TAG_2
       fi
       if [[ " ${i} " =~ "ELS2" ]]; then
          send_log "ERROR" "Failure connecting: 192.168.5.$j" $TAG_1 $TAG_2
       fi
       if [[ " ${i} " =~ "R1" ]]; then
          send_log "INFO" "Connecting to db: 192.168.5.$j" $TAG_1 $TAG_2
       fi
       if [[ " ${i} " =~ "R2" ]]; then
          send_log "INFO" "Redirected request to backup" $TAG_1 $TAG_2
       fi
       if [[ " ${i} " =~ "R2" ]]; then
          send_log "INFO" "Loading data block $j" $TAG_1 $TAG_2
       fi

     done
  done
}

compare () {
  TAG_1=$1
  TAG_2=$2
  JSON=$(curl -s -X POST "https://logsight.ai/api/v1/logs/compare" \
    -H "accept: */*" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" \
    -d "{
        \"baselineTags\": { \"version\": \"$TAG_1\", \"region\": \"EU\"},
        \"candidateTags\": { \"version\": \"$TAG_2\", \"region\": \"EU\"}
    }")
  echo 'JSON:' $JSON
}


echo 'Send logs'
# "EL1" "ES1" "ELS1" "ELS2" "R1" "R2" "R3"
# c(v1, v2), Risk = 100
# c(v2, v3), Risk = 0
# c(v3, v4), Risk = 100
# c(v4, v5), Risk = 31

states=("R1" "R2" "R3")
send_logs 5 "v1" "EU" ${states[@]}

states=("EL1" "R1" "R2" "R3")
send_logs 5 "v2" "EU" ${states[@]}

states=("EL1" "ES1" "R1" "R2" "R3")
send_logs 5 "v3" "EU" ${states[@]}

states=("EL1" "ES1" "ELS1" "R1" "R2" "R3")
send_logs 5 "v4" "EU" ${states[@]}

states=("EL1" "ES1" "ELS1" "R1" "R2" "R3")
send_logs 5 "v5" "EU" ${states[@]}

states=("EL1" "ES1" "R1" "R2" "R3")
send_logs 5 "v6" "EU" ${states[@]}

states=("EL1" "R1" "R2" "R3")
send_logs 5 "v7" "EU" ${states[@]}

states=("ES1" "R1" "R2" "R3")
send_logs 5 "v8" "EU" ${states[@]}

echo 'Compare logs...sleeping 60 seconds...'
sleep 60
compare "v1" "v2"
compare "v2" "v3"
compare "v3" "v4"
compare "v4" "v5"
compare "v5" "v6"
compare "v6" "v7"
compare "v7" "v8"


# if you do POST request to https://logsight.ai/api/v1/logs/tags/values
# with body {"tagName": "yourtagname"} it returns the values for each tag

list_logs () {
  JSON=$(curl -s -X POST "https://logsight.ai/api/v1/logs/tags/filter" \
    -H "accept: */*" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" \
    -d "{}")

  echo 'JSON:' $JSON
}
echo 'List logs'
list_logs
