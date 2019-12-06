## Virtualbox lab environment for LFS258 Kubernetes Fundamentals training and practicing for CKA exams

The Vagrant file creates following Ubuntu (Xenial) VMs - master(s), worker and load-balancer.  
Master nodes have been prepared for installing k8s cluster with ```kubeadm``` commands using [kubernetes\kubeadm-config.yaml](./kubernetes/kubeadm-config.yaml) file
Load-balancer node has been prepared with:
  - simple haproxy configuration to test external access for k8s services exposed with nodePort
  - simple nfs export ```/opt/sfw/``` for testing persistent volumes

### Simpe lab diagram 
<img src="https://raw.githubusercontent.com/michalgutowski/cka-lab/master/lab-diagram.svg?sanitize=true">

### Cluster networking:  
Internal IP addresses (you can copy the following to your ```/etc/hosts``` file):   
```bash
192.168.56.100 ckalb  
192.168.56.101 ckamaster1 ckamaster  
192.168.56.102 ckamaster2  
192.168.56.103 ckamaster3  
192.168.56.104 ckaworker1  
```
Pod CIDR: 
```
10.244.0.0/16 (with Calico via enp0s8 interface)  
```
### Building clusters  
For most labs one master + one worker + additional lb/nfs node is enough. To initially build the cluster execute:  
```
# vagrant up ckamaster1 ckaworker1 ckalb
```  
All VMs will be created under CKA group in your Virtualbox.  
Once the cluster is up and running you can suspend it using:  
```
# vagrant suspend ckamaster1 ckaworker1 ckalb    
```
And later resume it whenever needed:
```
# vagrant resume ckamaster1 ckaworker1 ckalb   
```

For the master HA labs you will need to build three masters + lb node
```
# vagrant up ckamaster1 ckamaster2 ckamaster3 ckalb
```  
### Connecting to cluster nodes 
You can connect to all nodes using student user and submiting the private key e.g.:  
```
# ssh student@192.168.56.101 -i id_rsa
``` 
### Installing k8s master 
In order to install first kubernetes master node connect to ckamaster1 and execute:  
```
$ sudo -i
# apt install docker.io kubeadm=1.15.1-00 kubectl=1.15.1-00 kubelet=1.15.1-00
# kubeadm init --config=kubeadm-config.yaml --upload-certs| tee kubeadm-init.out
```  
Now it's your turn to figure how to add additional worker or master nodes. Have fun!

### Useful kubectl commands that helps you with creating objects 

Creating a deployment  
```$ kubectl run```   
  
Creating a pod  
```$ kubectl run --restart=Never```  
  
Creating a job  
```$ kubectl run --restart=OnFailure```
  
Creating a cronjob   
```$ kubectl run --restart=OnFailure --schedule=“* * * * *”```  

#### Notes
  - Passwordless ssh has been configured between nodes using root user
  - Password for user **student**: **welcome1**

Tested on MacOS 10.14.6 (Mojave), Vagrant 2.2.5 and VirtualBox 6.0.8, Ubuntu/Xenial vagrant box v. 20191114.0.0.  
Min. 16GB of RAM recommended.
