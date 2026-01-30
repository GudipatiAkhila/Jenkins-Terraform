#!/bin/bash



#Partition the disk
growpart /dev/nvme0n1 4

lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -L +10G /dev/mapper/RootVG-rootVol
lvextend -l +100%FREE /dev/mapper/RootVG-homeVol


xfs_growfs /
xfs_growfs /var
xfs_growfs /home


#Installation commands from Jenkins 
sudo curl -o /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/rpm-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2023.key

# Add required dependencies for the jenkins package
sudo yum install fontconfig java-21-openjdk -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins



# After logging to Jenkins
1 . Install plugins 
2 . Add Credentials - settings-> Manage Jenkins -> Credentials 
3.  Add Node - ettings-> Manage Jenkins -> Node 
 



