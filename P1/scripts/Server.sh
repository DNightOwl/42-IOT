sudo apt-get update
      sudo apt-get upgrade -y
      sudo apt-get install -y curl
      #install k3s server
      curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 
      #find the token and put it in the shared folder so we can access to it from the worker machine 
      cat /var/lib/rancher/k3s/server/node-token > /vagrant/confs/token.txt