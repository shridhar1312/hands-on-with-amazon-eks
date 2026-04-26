
#--------- Updated script----------------

#!/bin/bash

set -e

echo "--------------------------------------------------"
echo "Installing Required Tools for EKS Setup"
echo "--------------------------------------------------"

echo "---------- INSTALLING NANO ----------"
sudo yum install -y nano

echo "Nano installed successfully"
nano --version | head -1

echo "---------- INSTALLING kubectl ----------"

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl

chmod +x ./kubectl
mkdir -p $HOME/bin
cp ./kubectl $HOME/bin/kubectl

export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

kubectl version --client

echo "---------- INSTALLING eksctl ----------"

curl --silent --location \
https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz \
| tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

echo "eksctl installed successfully"
eksctl version

echo "---------- INSTALLING HELM ----------"

export VERIFY_CHECKSUM=false
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "Helm installed successfully"
helm version

echo "---------- VERIFYING AWS CLI ----------"

aws --version

echo "--------------------------------------------------"
echo "All required tools installed successfully"
echo "--------------------------------------------------"


# echo "---------- INSTALLING NANO ----------"
# sudo yum install nano -y

# echo "---------- INSTALLING EKSCTL ----------"
# curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.147.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
# sudo mv /tmp/eksctl /usr/local/bin
# eksctl version


# echo "---------- INSTALLING HELM ----------"
# export VERIFY_CHECKSUM=false
# curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
