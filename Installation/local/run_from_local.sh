#!/bin/bash
# !!! Run this one from a machine which has docker installed and internet.

WORK_DIR=`pwd`
mkdir -p $WORK_DIR/remote/images

function prepare_docker_image(){
    while read -r image;
        do  
            out_put_image=$(echo $image | cut -d':' -f1 | sed 's/\//\./g')
            docker pull $image
            docker save $image -o ${WORK_DIR}/remote/images/$out_put_image.tgz
            echo "Save $image to $out_put_image.tgz"
        done < image.list
        echo "Please copy all .tgz file to remote/images folder"

}

# prepare_docker
prepare_docker_image
# prepare_python
