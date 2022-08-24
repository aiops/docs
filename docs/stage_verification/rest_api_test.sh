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
      \"tags\": {\"Version\": \"$TAG_1\", \"Region\": \"$TAG_2\"},
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

  for i in {1..$N}
  do
     echo "Sending message block #$i"
     send_log "INFO" "Connecting to db: 192.168.5.$i" $TAG_1 $TAG_2
     send_log "INFO" "Loading data block $i" $TAG_1 $TAG_2
     send_log "ERROR" "Cannot connect to cache id: $i" $TAG_1 $TAG_2
     send_log "INFO" "Redirected request to backup" $TAG_1 $TAG_2
  done
}

echo 'Send logs'
send_logs 5 "v1" "EU"
send_logs 7 "v2" "EU"
echo "Sending extra messages"
for i in {1..10}
do
  send_log "ERROR" "Failure to load customer data" "v2" "EU"
done

compare () {
  TAG_1=$1
  TAG_2=$2
  JSON=$(curl -s -X POST "https://logsight.ai/api/v1/logs/compare" \
    -H "accept: */*" -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" \
    -d "{
        \"baselineTags\": { \"Version\": \"$TAG_1\", \"Region\": \"EU\"},
        \"candidateTags\": { \"Version\": \"$TAG_2\", \"Region\": \"EU\"}
    }")
  echo 'JSON:' $JSON
}

sleep 60
echo 'Compare logs'
compare "v1" "v2"