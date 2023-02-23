# $${\color{red} ITI-Final-Project}$$
> *About the project:
*Project for deploying  first by build the infrastructure by *Terraform* using GCP which consist of
- GKE Cluster
- VPC
- 2 Subnets 
- 1 VM
* Deploy jenkins in GKE Cluster using Controller VM *
*Use jenkins to build and deploy this app in slave pod in GKE cluster* 

###                    ______________________________________________________________________________________________

# *Project - Structure*

![Demo](https://user-images.githubusercontent.com/118537759/220793624-86bbcd94-6980-4246-94af-476424471fbe.jpg)

###                ______________________________________________________________________________________________

# *The Requirement to Start Project*

""IN YOUR LOCAL MACHINE""
- Install Terraform
- Install Docker

# *First
> Build docker image (Slave-image) from docker file*  - Push the image to Docker Hub


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
![Screenshot from 2023-02-22 13-40-26](https://user-images.githubusercontent.com/118537759/220793779-546f8de8-af43-42d4-bd79-477581f57209.png)


*Docker Hub Account*
![Screenshot from 2023-02-22 13-41-07](https://user-images.githubusercontent.com/118537759/220793790-69ba465b-779e-4178-a1f6-f7960ebc2e2c.png)


###                    ______________________________________________________________________________________________


# Second
> Run Terraform Files Using This Commands*
```
terraform init 
```
![Screenshot from 2023-02-23 13-18-50](https://user-images.githubusercontent.com/118537759/220966939-11e58006-227f-4d9e-a59b-f2bf0829dab9.png)

```
terraform plan  
```
![Screenshot from 2023-02-23 13-22-41](https://user-images.githubusercontent.com/118537759/220966992-e84a39fc-278f-4d17-a330-d702f081ca9a.png)

```
terraform apply  
```
![Screenshot from 2023-02-23 13-37-58](https://user-images.githubusercontent.com/118537759/220967030-8bdc8403-bc06-4c93-8432-eccbcb6b2ef8.png)

## -------------------------------------------

![Screenshot from 2023-02-23 13-38-19](https://user-images.githubusercontent.com/118537759/220967077-4e26c22a-857a-4505-b0e1-48558e0fc3f4.png)


###                    ______________________________________________________________________________________________


# Third
> SSH to controller-vm and follow this steps

* installing git
```
sudo apt update  
```
```
sudo apt install git  
```
![Screenshot from 2023-02-23 13-47-10](https://user-images.githubusercontent.com/118537759/220967993-e6e183e7-8484-4fb0-b1d9-a9f76666a3f0.png)

* Get deployment files (yaml-files) and Spec.Script.sh from my repo 
```
git clone git@github.com:Alielhaba/ITI-Final-Project.git
```
![Screenshot from 2023-02-23 13-50-33 (copy)](https://user-images.githubusercontent.com/118537759/220968239-07c97cfa-e12e-43d7-853b-7ad2bc37dafe.png)

* Run Spec.Script.sh
```
bash Spec.Script.sh
```
![Screenshot from 2023-02-23 13-55-46](https://user-images.githubusercontent.com/118537759/220968619-86b9b02c-2c03-48e7-83c9-b2436f24036a.png)

* Connect Controller VM to  GKE Cluster 
```
gcloud container clusters get-credentials main-cluster --zone us-east1-b --project ali-elhabal-378620
```
![Screenshot from 2023-02-23 14-03-27](https://user-images.githubusercontent.com/118537759/220968725-4dfb5df1-2939-44a8-8b95-3df0616cd946.png)

* Create Jenkins NameSpace
```
kubectl create  namespace jenkins
```
![Screenshot from 2023-02-23 14-12-17](https://user-images.githubusercontent.com/118537759/220968801-8006d895-400c-4e5c-a087-d02faccc8abc.png)

* Deploy jenkins and slave files 
```
kubectl create -f deployment-files
```
![Screenshot from 2023-02-23 14-12-17](https://user-images.githubusercontent.com/118537759/220968835-c42b8b54-73f2-4050-ad6c-9889cc480469.png)

* Get service IP and Port to brows jenkins
```
kubectl get svc
```
![Screenshot from 2023-02-23 14-20-14](https://user-images.githubusercontent.com/118537759/220968906-1dfaf1a1-3b35-4dea-ab4d-1f300afcd48d.png)

##   ----------------------------------------------------------

![Screenshot from 2023-02-23 14-20-48](https://user-images.githubusercontent.com/118537759/220969280-a600bc76-5a0c-4eb9-aa87-90b700796ee7.png)

* Get a shell from jenkins pod to get Administrator Password
```
kubectl exec --stdin --tty -n jenkins jenkins-5667d7d786-2qpp2 -- /bin/bash
```
![Screenshot from 2023-02-23 14-23-29](https://user-images.githubusercontent.com/118537759/220969325-b5569d85-98cb-48e8-95e2-cace0e732ae7.png)

##   ----------------------------------------------------------

![Screenshot from 2023-02-23 14-24-13](https://user-images.githubusercontent.com/118537759/220969430-4895ae20-3326-4ff0-b8de-ed3377f289dd.png)

##   ----------------------------------------------------------

![Screenshot from 2023-02-23 14-26-18](https://user-images.githubusercontent.com/118537759/220969548-dd8d4988-d974-45ad-866c-fc1381645d53.png)


###                    ______________________________________________________________________________________________


>*create slave node in jenkins and connect it with slave pod in GKE Cluster

![Screenshot from 2023-02-23 14-40-14](https://user-images.githubusercontent.com/118537759/220974355-099bca85-ccd7-43c8-9b99-a364117a8d2d.png)

##   ----------------------------------------------------------

> Make sure ssh Connection in slave pod is started 
> And Authentication is required 
   >> create Credential with user-name (Jenkins) and password
   >> go shell in slave pod and create passwd for jenkins user (same jenkins Credential password )
   
![Screenshot from 2023-02-23 14-40-41](https://user-images.githubusercontent.com/118537759/220974426-c28ed4ca-17a3-4e62-9eb5-63e491817c8f.png)

*'craete pipline with this configuration only' 

![Screenshot from 2023-02-23 18-58-05](https://user-images.githubusercontent.com/118537759/220976981-3e23cb62-bde4-4c6f-bc40-7325cf7a7bad.png)

##   ----------------------------------------------------------

![Screenshot from 2023-02-23 18-58-22](https://user-images.githubusercontent.com/118537759/220977064-2c22f51c-ea09-4a18-83be-0ebdbd4c6a00.png)

*'then build the pipline' 

![Screenshot from 2023-02-23 18-13-59](https://user-images.githubusercontent.com/118537759/220977498-8d4d70f0-6c7f-4b0a-86d8-8039e6787832.png)

> pipline stages
>> Build 
>> deploy 

###                    ______________________________________________________________________________________________
# $${\color{green} finally}$$

* get ip address of app service add brows using it 

![Screenshot from 2023-02-23 19-39-34](https://user-images.githubusercontent.com/118537759/220987058-48327681-22cf-42f3-844b-a8d33b109fd1.png)

# The Deployed App 

![Screenshot from 2023-02-23 18-12-58](https://user-images.githubusercontent.com/118537759/220987261-82bd2d46-b260-4590-815d-34f08e71f1dd.png)


# $${\color{green}Thank You}$$


