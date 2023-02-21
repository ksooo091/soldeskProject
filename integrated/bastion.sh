#!bin/bash
sudo apt-get update -y
sudo apt-get remove docker docker-engine docker.io -y
sudo apt-get install docker.io -y
sudo service docker start
sudo chmod 666 /var/run/docker.sock
sudo usermod -a -G docker ubuntu

# curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.9/2023-01-11/bin/linux/amd64/kubectl
# chmod +x ./kubectl
# mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
# echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

