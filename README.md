# Example with KubeAdm

Code to deploy a Kubernetes cluster in AWS using kubeadm.

+ No cloudformation nor terraform
+ No roles
+ No packer

Implementation of

http://kubernetes.io/docs/getting-started-guides/kubeadm/

Not generic at all (I may expand it to make it more generic).

## Requirements

```
sudo apt-get install python-pip ansible awscli
pip install -U boto
```

## Usage
It's good practice to pass the name of the profile in our AWS credentials

```
AWS_PROFILE=k8sgon ansible-playbook create_keypair.yml
eval `ssh-agent -s`
ssh-add ~/.ssh/k8s-keypair.pem
AWS_PROFILE=k8sgon ansible-playbook create_cluster.yml
```
