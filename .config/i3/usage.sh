#!/bin/bash
# Function to perform login
login() {
    local username=$1
    local password=$2

    # Create a temporary file for storing cookies
    cookie_file=$(mktemp)

    # Perform login request
    response=$(curl -s -X POST -c "$cookie_file" \
        -d "kerio_username=$username" \
        -d "kerio_password=$password" \
        https://kerio.partdp.ir/internal/dologin.php)

    # Extract session and token from cookies
    session=$(grep 'SESSION_CONTROL_WEBIFACE' "$cookie_file" | awk '{print $NF}')
    token=$(grep 'TOKEN_CONTROL_WEBIFACE' "$cookie_file" | awk '{print $NF}')

    echo "{\"session\": \"$session\", \"token\": \"$token\"}"
}

# Function to get quota
get_quota() {
    local session=$1
    local token=$2

    # Create JSON payload
    payload='{"jsonrpc": "2.0", "id": 1, "method": "Batch.run", "params": {"commandList": [{"method": "MyAccount.get"}, {"method": "MyAccount.getRasIntefaces"}]}}'

    # Perform request with session and token
    response=$(curl -s -X POST \
        -H "Cookie: SESSION_CONTROL_WEBIFACE=$session; TOKEN_CONTROL_WEBIFACE=$token" \
        -H "X-Token: $token" \
        -d "$payload" \
        https://kerio.partdp.ir/lib/api/jsonrpc/)

    echo "$response"
}

# Function to convert bytes to MB
to_mb() {
    awk "BEGIN {printf \"%.4f\n\", \$1 / (1024 * 1024)}"
}

bytes_to_mb() {
    local bytes=$1
    local mb=$(echo "scale=4; $bytes / (1024 * 1024)" | bc)
    echo "$mb"
}

# Perform login
login_data=$(login 'youtUsername' 'yourPassword')

# Parse session and token from login response
session=$(echo "$login_data" | jq -r '.session')
token=$(echo "$login_data" | jq -r '.token')

if [ "$session" != "null" ] && [ "$token" != "null" ]; then
    quota_data=$(get_quota "$session" "$token")
    # Extract necessary values from quota data using jq
    day_up=$(echo "$quota_data" | jq -r '.result[0].result.quota.day.up')
    day_down=$(echo "$quota_data" | jq -r '.result[0].result.quota.day.down')


    day_up=$(bytes_to_mb "$day_up")
    day_down=$(bytes_to_mb "$day_down")

    # Calculate percentage
    mysum=$(echo "$day_up + $day_down" | bc)
    usednow=$(echo "$mysum - 1024" | bc)
    percent_used=$(echo "scale=4; ($usednow / 1024) * 100 " | bc)
    positive_num=$(echo "$percent_used" | sed 's/-//') # Absolute value

    echo "⛽︎ : $(printf "%.2f" "$positive_num")%"
else
    echo "Failed to login"
fi
