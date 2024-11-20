#!/bin/bash


## Get cpu name
get_cpu_name() {
    echo "##### CPU INFO #####"
    cat /proc/cpuinfo | awk -F: 'NR==5 {printf "Cpu Name: %s\n", $2}'
    echo
}


get_cpu_usage() {
    echo "##### CPU USAGE #####"
    mpstat | awk 'NR==4 {printf "User: %.2f%%, System: %.2f%%, IDLE: %.2f%%\n", $3, $5, $12}'
    echo
}

## Get MEM Usage
get_mem_usage() {
    echo "##### MEM USAGE #####"
    free --mega | awk 'NR==2 {printf "Used: %s MB, Free: %s MB, Usage: %.1f%%\n", $3, $4, ($3/$2)*100}'
    echo
}

## Get Disk Usage
get_disk_usage() {
    echo "##### Disk Usage #####"
    df -h --total | awk '/^total/ {printf "Used: %s, Avail: %s, Total: %s, Usage: %i%%\n", $3, $4, $2, $5}' 
    ##df -h --total | awk '(/Filesystem/ || /total/) {printf "%s  %s  %s \n", $3, $4, $2, $5}'      //Alternative approach but harder to read programmatically
    echo
}

## Top 5 Proc by CPU
get_top_cpu_processes() {
    echo "### Top 5 Processes by CPU Usage ###"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
    echo
}

get_top_memory_processes() {
    echo "### Top 5 Processes by Memory Usage ###"
    ps -eo pid,comm,%mem --sort=-%mem | head -6
    echo
}

# Execute functions
echo "Server Performance Stats"
echo "========================="
get_cpu_name
get_cpu_usage
get_mem_usage
get_disk_usage
get_top_cpu_processes
get_top_memory_processes
