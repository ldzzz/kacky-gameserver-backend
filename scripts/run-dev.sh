#!/bin/bash

RED="\e[31m"
ENDCOLOR="\e[0m"

Help()
{
   # Display Help
   echo "DO NOT USE IN PRODUCTION    DO NOT USE IN PRODUCTION    DO NOT USE IN PRODUCTION"
   echo "DO NOT USE IN PRODUCTION    DO NOT USE IN PRODUCTION    DO NOT USE IN PRODUCTION"
   echo "DO NOT USE IN PRODUCTION    DO NOT USE IN PRODUCTION    DO NOT USE IN PRODUCTION"
   echo
   echo "Helper script for development."
   echo
   echo "Syntax: ./run-dev.sh [-r|h]"
   echo "options:"
   echo "r     Re-initialise database. Use whenever db schema changes"
   echo "h     Print this Help."
   echo
}

while getopts ":rh" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      r) # reinit db
         Remove=1;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done


# re-initialize DB
if [[ $Remove  ]]; then
    echo  -e "${RED}Removing db tables..${ENDCOLOR}"
    goose down
    echo -e "${RED}Initialising db schema${ENDCOLOR}"
    goose up
    echo -e "${RED}Seeding db${ENDCOLOR}"
    goose -dir ${SEEDS_MIGRATION_DIR} --no-versioning up
fi

# run backend
echo -e "${RED}Starting backend..${ENDCOLOR}"
go run cmd/kacky-gameserver-backend/main.go
