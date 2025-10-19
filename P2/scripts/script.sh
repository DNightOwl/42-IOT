
 sudo apt-get update
      sudo apt-get upgrade -y
      sudo apt-get install -y curl
      #install k3s server
      curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
    sleep 10
  kubectl apply -f /home/vagrant/confs/app1.yaml
  kubectl apply -f /home/vagrant/confs/app2.yaml
  kubectl apply -f /home/vagrant/confs/app3.yaml
  kubectl apply -f /home/vagrant/confs/ingress.yaml
  kubectl apply -f /home/vagrant/confs/configMaps.yaml

  sudo vim /etc/hosts
  echo "192.168.56.110 app1.com" | sudo tee -a /etc/hosts
  echo "192.168.56.110 app2.com" | sudo tee -a /etc/hosts
  echo "192.168.56.110 app3.com" | sudo tee -a /etc/hosts

  
