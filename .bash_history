cat /var/lib/jenkins/secrets/initialAdminPassword
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker
docker version
sudo usermod -aG docker $dalton
sudo usermod -aG docker dalton
docker version
cat /etc/group
cat /etc/group | grep docker
sudo usermod -aG docker dalton
docker version
sudo su
sudo usermod -aG docker dalton
sudo groupadd docker
sudo usermod -aG docker dalton
cat /etc/passwd
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y virtualbox virtualbox-ext-pack
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sourc
sudo apt-get update
sudo apt-get install -y kubectl
kubectl version
kubectl get nodes
az login
az aks get-credentials --resource-group klaster_demo --name k8s-node
kubectl get nodes
exit
