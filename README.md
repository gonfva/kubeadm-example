# Example with KubeAdm

Code to deploy a Kubernetes cluster in AWS using kubeadm.

+ No cloudformation nor terraform
+ No roles
+ No packer

This is not the way I would deploy things, but it is nice to practice

## Build AMI

Take a look at the file packer/region-dublin.json and change what is required. Then run
```
AWS_PROFILE=gonzalo_personal_projects packer build -var-file=packer/region-dublin.json packer/centos.json
```

Once you get a new AMI, you can change it in the vars.yml as with the other stuff

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
+ Multi-AZ.
+ EKS
+ autoscaling groups.
+ ALB to connect to the instance instead of port in the machine.
+ cloudformation/terraform
+ (not to use) name for instances (pets vs cattle).
+ If we use names, we may want to use inventory (ansible mechanism).
+ The canonical way is to have everything on private subnets and have public subnets with elastic load balancer in a public subnet connecting to the cluster and maybe a bastion host. In this example, all the instances have ips in a specific range but also a public IP.

I just wanted to do a quick update of this old project and see if it is still relevant. It took more than expected to move it to a presentable form, but the basic mechanism (`kubeadm init` + `kubeadm join` is surprisingly still totally relevant)
