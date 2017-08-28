# AviatrixSalesDemoInfra
This repository creates AWS infrastructure for Aviatrix Sales Demo through Terraform.

## Description
The terraform script will create the following:

* One VPC with a public and private subnet in us-east-1.
* One VPC with a public and private subnet in us-west-1. 
* One EC2 instance located in the public subnet of the VPC (us-east-1), loaded with pip, iperf3 and Flask. (named Client)
* One Windows instance in the public subnet of the VPC (us-east-1). 
* One EC2 instance located in the public subnet of the VPC (us-west-1), loaded with pip, iperf3 and an apache tomacat7 webserver. (named Server)
* One Aviatrix Controller EC2 Instance located in the public subnet of the VPC (us-west-1) (named AviatrixController).

## Step by step procedure:
1. Begin by [installing terraform](https://www.terraform.io/intro/getting-started/install.html)
2. Run the command below to generate and show an execution plan -
  ```
  terraform plan
  ```
 3. Run the command below to create the infrastructure -
 ```
  terraform apply
 ```
 4. Check the AWS Console to confirm the infrastructure was created succesfully. 
 5. ssh in to the EC2 instance named Client in us-east-1. 
 6. Clone the Demo Application in to the EC2 instance. 
  ```
  git clone https://github.com/AviatrixSystems/AviatrixSalesDemoApp.git
 ```
 7. ssh in to the Windows EC2 instance in us-east-1 using [Microsoft Desktop Client](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients) and the appropriate credentials from AWS.
 8. Download [pingplotter](https://www.pingplotter.com/) into the Windows instance. 
 
## Destroy infrastructure [optional]

To destroy the infrastrucutre run the following command - 
 ```
  terraform destroy
 ```
