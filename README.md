## Virtualbox lab environment for LFS258 Kubernetes Fundamentals training and practicing for CKA exams

The Vagrant file creates following Ubuntu (Xenial) VMs - master(s), worker and load-balancer.  
Master nodes have been prepared for installing k8s cluster with kubeadm commands.
Load-balancer node has been prepared with:
  - simple haproxy configuration to test external access for k8s services exposed with nodePort
  - simple nfs export ```/opt/sfw/``` for testing persistent volumes
  
### K8s networking:  
Internal IP addresses:   
```bash
192.168.56.100 (ckalb)  
192.168.56.101 (ckamaster1)  
192.168.56.102 (ckamaster2)  
192.168.56.103 (ckamaster3)  
192.168.56.104 (ckaworker1)  
```
Pod CIDR: 
```
10.244.0.0/16 (with Calico)  
```
### Building clusters  
For most labs one master + one worker + additional lb/nfs node is enough. To initially build the clsuter execute:  
```
# vagrant up ckamaster1 ckaworker1 ckalb
```  
All VMs will be created as CKA group in your Virtualbox.
Once the cluster is up and running you can use suspend it:  
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
You can connect to all nodes using student user and submiting the private key:  
```
# ssh student@ckamaster -i id_rsa
```  

### Notes
  - Nodes are ready for k8s installation with kubeadm using ```kubeadm-config.yaml``` file
  - Passwordless ssh has been configured between nodes using root user
  - Passowrd for user **student**: **welcome1**
