

# Sample application for Cyware assignment

This is a sample application built on terraform, python flask, AWS cloud, docker.

## Setup and Test locally

-   Build docker image and run the image to test the application locally

```bash
#build docker image locally
# cd into the path where we have DockerFile and then run below command
$ docker build -t shashankjaintm/test-application-cyware-assignment:v0.0.1 .
#Run docker image
$ docker run -p 80:8080 shashankjaintm/test-application-cyware-assignment:v0.0.1
```

-  Push the docker image to the docker hub
```bash
$ docker push shashankjaintm/test-application-cyware-assignment:v0.0.1
```

-  deploy the docker image using docker compose 
```bash
$ docker compose up
```

Serve http://localhost/hello

## Terraform Requirements
 -  Terraform version  = 1.3.9
 -  Terraform provider =~> 4.64
 -  Terraform state    = aws-s3-bucket: terraform-assignment-state
 -  terraform lock     = terraform_lock
- 

## Bring AWS resources using terraform 
IAM user with terraform plan and apply permissions on the resources is needed.

 We can run the terraform resources from local or any CI/CD to bring up the terraform resources using the IAM user Credentials

 - Terraform Init
```bash
$terraform init
```
- Terraform Plan 
```bash
$terraform plan
```
 - Terraform apply
```bash
$terraform apply
```
 - Terraform apply with resource target
```bash
$terraform apply -target aws_vpc.vpc-assignment
```

 Serve http://web-lb-959843231.eu-central-1.elb.amazonaws.com/hello

- `Can change based on the resource creation, this is the dns name of the Application load balancer`