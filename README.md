# $${\color{red} ITI-Final-Project}$$
## About the project:
*Project for deploying  first by build the infrastructure by *Terraform* using GCP which consist of
- GKE Cluster
- VPC
- 2 Subnets 
- 1 VM
* Deploy jenkins in GKE Cluster using Controller VM *
*Use jenkins to build and deploy this app in slave pod in GKE cluster* 

###                ______________________________________________________________________________________________

# *Project - Structure*

![Demo](https://user-images.githubusercontent.com/118537759/220793624-86bbcd94-6980-4246-94af-476424471fbe.jpg)


# *Requires to Start Project*

""IN YOUR LOCAL MACHINE""
- Install Terraform
- Install Docker

# First
>*Build docker image (Slave-image) from docker file*  - Push the image to Docker Hub


* Build the Docker image  (Slave-image)
```
 docker build . -t slave
```
![Screenshot from 2023-02-22 12-48-05](https://user-images.githubusercontent.com/118537759/220793716-e76b0a28-c3fe-42bc-95c9-aa1f1a1b4848.png)
* Tag Docker Image 
```
docker image tag slave ali3elhabal/slave:latest
```
![Screenshot from 2023-02-22 12-48-41](https://user-images.githubusercontent.com/118537759/220793753-d68acc67-8d47-4f4c-bc4c-08fe3d6e784f.png)
* Login to Docker Hub to push slave image 
- insert your user-name and password
```
docker login
```
* Then push slave image
```
docker push ali3elhabal/slave:latest
```
![Screenshot from 2023-02-22 13-40-26](https://user-images.githubusercontent.com/118537759/220793779-546f8de8-af43-42d4-bd79-477581f57209.png)#

*Docker Hub Account*
![Screenshot from 2023-02-22 13-41-07](https://user-images.githubusercontent.com/118537759/220793790-69ba465b-779e-4178-a1f6-f7960ebc2e2c.png)


# Third
>*SSH to private-vm and follow this steps

* installing git
```
sudo apt update  
```
```
sudo apt install git  
```
* Run Spec.Script.sh
```
bash Spec.Script.sh
```

* Get deployment files (yaml-files) from my repo 
```
git clone git@github.com:Alielhaba/ITI-Final-Project.git
```

* Connect Controller VM to  GKE Cluster 
```
gcloud container clusters get-credentials main-cluster --zone us-east1-b --project ali-elhabal-378620
```
* Create Jenkins NameSpace
```
kubectl create  namespace jenkins
```
* Deploy jenkins and slave files 
```
kubectl create -f deployment-files
```

* Get service IP and Port to brows jenkins
```
kubectl get svc
```
* Get a shell from jenkins pod to get Administrator Password
```
kubectl exec --stdin --tty -n jenkins jenkins-5667d7d786-2qpp2 -- /bin/bash
```

# $${\color{green}Thank You}$$


