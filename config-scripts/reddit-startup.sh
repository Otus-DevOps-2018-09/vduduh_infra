#!/bin/bash
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
ruby -v
bundle -v
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo cat <<EOF > /etc/apt/sources.list.d/mongodb-org-3.2.list
deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse
EOF
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl enable mongod
sudo systemctl start mongod
sudo systemctl status mongod
cd /home/appuser
sudo apt install git -y
git clone -b monolith https://github.com/express42/reddit.git 
cd reddit && bundle install
puma -d
ps aux | grep puma"