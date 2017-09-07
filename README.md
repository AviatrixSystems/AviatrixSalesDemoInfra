# AviatrixSalesDemoInfra
This terraform script creates an AWS environment for demoing real world Aviatrix usecases.

## Description
The terraform script will create the following:

* One VPC with a public and private subnet in specified region consisting of -
  * One EC2 instance located in the public subnet, loaded with pip, iperf3 and Flask. (named Client)
  * One Windows instance in the public subnet. 
* One VPC with a public and private subnet in the other specified region consisting of - 
  * One EC2 instance located in the public subnet, loaded with pip, iperf3 and an apache tomacat7 webserver (named Server).
  * One Aviatrix Controller EC2 Instance located in the public subnet (named AviatrixController).

## New AWS Account
If this a new AWS Account then - 
1. Get the Aviatrix product from the [AWS Marketplace](https://aws.amazon.com/marketplace/fulfillment?productId=109cd06c-210a-4fa4-839b-708683c66dc6&ref_=dtl_psb_continue&region=us-east-1)
2. Click on the Manual Launch with EC2 Console, API or CLI
3. Click on the button that says "Accept Software Terms"

## Step by step procedure:
1. Begin by [installing terraform](https://www.terraform.io/intro/getting-started/install.html)
2. Clone the following repositories anywhere on your local machine. 
  ```
  git clone https://github.com/AviatrixSystems/AviatrixSalesDemoInfra.git
 ```
3. Create and IAM user with admin access policy
4. Add the access_key, secret_key and the desired regions in the terraform.tfvars file or delete the terraform.tfvars file and fill in the same parameters when it is prompted by the shell after running the terraform commands. 
4. Run the command below in your local copy (in the DemoTerraform folder) to generate and show an execution plan -
  ```
  terraform init
  terraform get
  terraform plan
  ```
 5. If there is no error then run the command below to create the infrastructure -
 ```
  terraform apply
 ```
 6. Check the AWS Console to confirm the infrastructure was created succesfully. 
 7. ssh in to the EC2 instance named Client. 
 8. Clone the Demo Application in to the EC2 instance. 
  ```
  git clone https://github.com/AviatrixSystems/AviatrixSalesDemoApp.git
  ```
  ```
  git clone https://github.com/AviatrixSystems/DirectConnectCostCalculator.git
 ```
 9. ssh in to the Windows EC2 instance using [Microsoft Desktop Client](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients) and the appropriate credentials from AWS.
 10. Download [pingplotter](https://www.pingplotter.com/) into the Windows instance. 

## Debugging Errors
* If the Aviatrix Console ECS instance is already present on the AWS account then an error will occur.
* If the shell states that specific EIPs already exist, delete the terraform.tfstate and terraform.tfstate.backup.
* If the shell states that roles and policies exist even after deleting the .tfstate files then check to see if those roles and policies already exist and delete them from the AWS management console.
## Destroy infrastructure [optional]

To destroy the infrastructure run the following command - 
 ```
  terraform destroy
 ```
