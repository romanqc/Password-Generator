#!/bin/bash

# Function to generate the password
generate_password() {
    local length=$1
    local include_numbers=$2
    local include_symbols=$3
    local characters='[:alnum:]'

    if [ "$include_numbers" = true ]; then
        characters+='0-9'
    fi

    if [ "$include_symbols" = true ]; then
        characters+='!@#$%^&*()_-'
    fi
    
    # Generates a random string of characters using /dev/urandom and character filtering.
    < /dev/urandom tr -dc "$characters" | head -c "$length"
}

# Main script
echo "Password Generator"
read -p "Enter the length of the password: " length
read -p "Include numbers? (yes/no): " include_numbers
read -p "Include symbols? (yes/no): " include_symbols

# Convert user input to lowercase
include_numbers=$(echo "$include_numbers" | tr '[:upper:]' '[:lower:]')
include_symbols=$(echo "$include_symbols" | tr '[:upper:]' '[:lower:]')

# Check if user wants to include numbers and symbols
if [ "$include_numbers" = "yes" ]; then
    include_numbers=true
else
    include_numbers=false
fi

if [ "$include_symbols" = "yes" ]; then
    include_symbols=true
else
    include_symbols=false
fi

# Generate and display password
password=$(generate_password "$length" "$include_numbers" "$include_symbols")
echo "Generated Password: $password"
