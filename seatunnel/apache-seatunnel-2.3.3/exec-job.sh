#!/bin/bash

# t_user
export XZS_DATABASE="my_xzs"

for job in `ls config/*.config`;
do
    config_name=${job##*/}
    job_name=${config_name%.*}
    ./bin/seatunnel.sh --async --name ${job_name} --config ${job}
done

./bin/seatunnel.sh --list
