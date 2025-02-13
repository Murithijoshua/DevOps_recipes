#!/bin/bash

default_log_location="/var/log"
new_archive_location="/var/log/archive"
compressed_dir=$(date +%Y%m%d).tar.gz
main (){
    #check if the archive directory exists
    if [ ! -d $new_archive_location ]; then
        mkdir $new_archive_location
    fi

    #check if log directory is provided as argument else force input
    
    if [ -z $1 ]; then
        echo "Please provide the log location"
        exit 1
    else
        log_location=$1
    fi
    #compress the directory and move to archive location
    tar -czf $new_archive_location/$compressed_dir $log_location
    echo "Log Archive Completed"
}
main $1