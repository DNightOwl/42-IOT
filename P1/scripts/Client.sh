sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y curl
sleep 5
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$(cat /vagrant/confs/token.txt) sh -
#install k3s agent after getting server's token #install k3s agent after getting server's token
