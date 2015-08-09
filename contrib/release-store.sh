access_token=`curl -sL "https://accounts.google.com/o/oauth2/token" \
  -d "client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&refresh_token=$REFRESH_TOKEN&grant_type=refresh_token" \
  | jq '.access_token'`

curl "https://www.googleapis.com/upload/chromewebstore/v1.1/items/$ITEM_ID" \
 -H "Authorization: Bearer $access_token"  -XPUT \
 --data-binary @"`pwd`/signr-chrome.zip"
