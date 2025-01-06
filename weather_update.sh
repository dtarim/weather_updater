#!/bin/bash

FILE="README.md"
CITIES=("Yalova" "Karabuk" "Eindhoven" "Amsterdam" "Kocaeli")
CITY=${CITIES[$INDEX]}
INDEX=$(($(date +%M) % ${#CITIES[@]}))
TEMPERATURE=$(curl -s "https://wttr.in/$CITY?format=%t")

# check if the Readme file is not exist
if [[ ! -f "$FILE" ]]; then
    echo "Error: $FILE is not exist.!"
    exit;
fi

# Platform MACOS
if [[ "$OSTYPE" == "darwin"* ]]; then

    sed -i '' "s/^$CITY : .*/$CITY : $TEMPERATURE/" "$FILE"
else # Platform GNU/Linux
    sed -i "s/^$CITY : .*/$CITY : $TEMPERATURE/" "$FILE"
fi

if !  grep -q "^$CITY :" "$FILE"; then
    echo "$CITY : $TEMPERATURE" >> "$FILE"
fi

echo "file is updated to $CITY : $TEMPERATURE"