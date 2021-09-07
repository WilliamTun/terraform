# Elastic Kubernetes Cluster Terraform Example

This is the code from a youtube tutorial \
on how to create an example Elastic Kubernetes Cluster \
by writing infrastructure as code with Terraform.

- Step 1. 
Create the EKS provider. Where you define the region \
and the fact that terraform will be used? \

- Step 2. 
Create the VPC or "Virtual private cloud" \
Create DNS hostname. DNS is a name that uniquely and absolutely names a computer \ 

Resource: 
https://www.youtube.com/watch?v=nIIxexG7_a8&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5

- Step 3. 
Create internet gateway \ 

Resource: 
https://www.youtube.com/watch?v=M1cQOaxFXJM&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=2 

- Step 4.
Create the Subnets & define the availability zone 

Resource:
https://www.youtube.com/watch?v=4Fm9CihWgkQ&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=3 


- Step 5. 
Create NAT gateway. 
Create EIPS

Resource:
https://www.youtube.com/watch?v=SL1reeQKJZs&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=4

- Step 6. 
Create the Route table 
Route tables contain a set of rules called routes 
that are used to determine where network traffic 
from either subnet or nat-gateway is directed. 

Types of route table: public, private, vpc peering 

- Step 7.
Create route table association

Resource: 
https://www.youtube.com/watch?v=dPQi70DSblo&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=5

- Step 8.
Create IAM role and attach a policy \
Create EKS note-group 

Resource:
https://www.youtube.com/watch?v=oYHZ3EPR094&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=6


========
# Key Terraform commands 

```
terraform fmt 
terraform plan 
terraform apply 
```

========
# Key Command line commands: 

Access key ID:
```export AWS_ACCESS_KEY_ID=<>```

secret access key:
```export AWS_SECRET_ACCESS_KEY=<>```

CONNECT to EKS cluster via kubeconfig
```
aws eks --region <region-code> update-kubeconfig --name <cluster name> 
aws eks --region eu-west-2 update-kubeconfig --name eks
```

========
# CHECKS

```
kubectl get nodes
kubectl get ns

kubectl get pods --all-namespaces
kubectl describe pod <NAMESPACE> 

kubectl get services

kubectl config view
kubectl config get-contexts 

kubectl api-resources --namespaced=true
```

### get storage class
kubectl get sc

#### get PersistentVolumesClaims 
kubectl get pvc


========
# ISTIO  


- Download istio 
- cd <Path to Istio>/Istio/istio-1.10.3

```
export PATH=$PATH:<Path to Istio>/Istio/istio-1.10.3/bin
istioctl install
kubectl label namespace default istio-injection=enabled
kubectl get pod -n istio-system
```

cd <Path to Istio>/Istio 

# install all add ones
```kubectl apply -f istio-1.10.3/samples/addons```

# kiali example

```
kubectl apply -f istio-1.10.3/samples/addons/kiali.yaml

kubectl get pod -n istio-system

kubectl port-forward svc/kiali -n istio-system 20001
```

Go to browser: \ 
127.0.0.1:20001

