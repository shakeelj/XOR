#!/bin/bash
WORK_DIR=`pwd`
HOME_FOLDER='/home/ec2-user'
PYTHON_VERSION='3.9.8'

function extract_docker_image(){
    # check if docker images exist in images folder
    ls images > image.list.load
    while read -r image;
    do
        docker load -i images/$image
    done < image.list.load
    # extract tgz to image
}

function install_packages(){
    # TODO: figure out how to install python offline
    yum localinstall -y $HOME_FOLDER/Installation/remote/packages/docker.rpm
    chmod +x packages/docker-compose
    cp -rp packages/docker-compose /usr/local/bin
    
    docker-compose -v
    systemctl start docker
}
function create_local_repo(){
    echo "Copying BaseOS.."
    cp -rp $HOME_FOLDER/ansible-packages/BaseOS /home/
    echo "Copying Appstream..."
    cp -rp $HOME_FOLDER/ansible-packages/AppStream /home/
    rm -f /etc/yum.repos.d/*
    cp -rp $HOME_FOLDER/Installation/remote/files/local.repo /etc/yum.repos.d/
    
    yum update -y
}

function install_python(){
    yum install -y wget unzip make openssl-devel bzip2-devel libffi-devel
    cd $HOME_FOLDER/Installation/remote/packages/Python-$PYTHON_VERSION
    ./configure
    make altinstall
    python3.9 --version
}

function start_docker_compose(){
    cd $HOME_FOLDER/Installation/remote/
    docker-compose up -d
}


create_local_repo
extract_packages
install_packages
extract_docker_image
install_python
start_docker_compose
