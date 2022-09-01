#!/bin/bash

#Define the string value
text=$(kubectl get svc --namespace $1 | grep web)

# Set space as the delimiter
IFS=' '

#Read the split words into an array based on space delimiter
read -a strarr <<< "$text"

url=${strarr[3]}

while [[ $url == "<pending>" ]]; do
    text=$(kubectl get svc --namespace $1 | grep web)
    read -a strarr <<< "$text"  
    url=${strarr[3]}
done

#Print the nginx URL
url=${strarr[3]}
echo "service URL"
echo $url