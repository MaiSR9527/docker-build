#!/bin/bash

for job in `ls config/*.config`;
do
        config_name=${job##*/}
    job_name=${config_name%.*}
    ${SEATUNNEL_HOME}/bin/seatunnel.sh --async --name ${job_name} --config ${job}
done

${SEATUNNEL_HOME}/bin/seatunnel.sh --list
