# Example with KubeAdm

Code to deploy a Kubernetes cluster in AWS using kubeadm.

+ No cloudformation nor terraform
+ No roles
+ No packer

This is not the way I would deploy things, but it is nice to practice

## Usage
It's good practice to pass the name of the profile in our AWS credentials

```
AWS_PROFILE=gonzalo_personal_projects ansible-playbook create_keypair.yml
eval `ssh-agent -s`
ssh-add ~/.ssh/k8s-keypair.pem
AWS_PROFILE=gonzalo_personal_projects ansible-playbook create_cluster.yml
```

## Room for improvement

I prefer to use :
+ EKS
+ autoscaling groups.
+ ALB to connect to the instance instead of port in the machine.
+ (not to use) name for instances (pets vs cattle).
+ If we use names, we may want to use inventory (ansible mechanism).
+ We may want some variables.
+ There is no multi-AZ.
+ I prefer to have everything on private subnets and have public subnets with elastic load balancer in a public subnet connecting to the cluster and maybe a bastion host. In this example, all the instances have ips in a specific range but also a public IP.

I just wanted to do a quick update of this old project and see if it is still relevant.
