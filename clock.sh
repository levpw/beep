#!/bin/bash

declare -A digits

digits[0]="
 ####  
#    # 
#    # 
#    # 
 ####  
"

digits[1]="
   #  
   #  
   #  
   #  
   #  
"

digits[2]="
 ####  
     # 
 ####  
#      
 ##### 
"

digits[3]="
 ####  
     # 
 ####  
     # 
 ####  
"

digits[4]="
#    # 
#    # 
 ##### 
     # 
     # 
"

digits[5]="
#####  
#      
#####  
     # 
#####  
"

digits[6]="
 ####  
#      
#####  
#    # 
 ####  
"

digits[7]="
#####  
    #  
    #  
    #  
    #  
"

digits[8]="
 ####  
#    # 
 ####  
#    # 
 ####  
"

digits[9]="
 ####  
#    # 
 ##### 
     # 
 ####  
"

display_time() {
    local current_time=$(date +"%H:%M:%S")
    local separator="  
     
  #  
     
  #  
     
"

    for i in {1..6}; do
        for j in $(seq 0 $((${#current_time} - 1))); do
            char="${current_time:$j:1}"
            if [[ $char == ":" ]]; then
                echo -n "$(echo "$separator" | sed "${i}q;d")"
            elif [[ $char =~ [0-9] ]]; then
                echo -n "$(echo "${digits[$char]}" | sed "${i}q;d")"
            fi
        done
        echo ""
    done
}

last_second=$(date +"%S")
while true; do
    clear
    display_time

    read -t 0.1 -n 1 input
    if [[ $input == "q" ]]; then
        break
    fi

    current_second=$(date +"%S")
    while [[ "$last_second" == "$current_second" ]]; do
        sleep 0.1
        current_second=$(date +"%S")
    done
    last_second=$current_second
done
