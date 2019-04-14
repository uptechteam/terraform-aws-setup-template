# Terraform Environment Initialization Template

This is terraform scripts skeleton to initialize basic project development environment in the cloud. Currently only AWS supported.

### General usage

Clone the repo and copy it to your project infrastructure folder, feel free to modify and add any resources you need. This project creates only most commonly used and basic resources for the fast development start.

```
git clone git@github.com:uptechteam/terraform-aws-setup-template.git
```

If you are not familar with terraform - check out documentation: https://www.terraform.io/docs/index.html  

Usage workflow:

 - create S3 bucket for terraform state backend with `cloud-init`


### Structure

Packages:

 - `cloud-init`
 - `environment`

#### Cloud Init

This package used to initialize AWS S3 bucket which will be used as backend for Terraform state of main `environment` module.  
More about different terraform backend here: https://www.terraform.io/docs/backends/index.html

##### Variables:

 - `project_name` - will be used for state bucket name in format: "{project_name}-terraform-state-bucket"
 - `aws_region` - bucket AWS region
 - `aws_access_key` - AWS Access Key
 - `aws_secret_key` - AWS Secret Key

Example of `.tfvars` can be found in the following folder  
More about variables: https://www.terraform.io/docs/configuration/variables.html

##### Usage

`terraform.tfvars` file with following variables should be created. Example can be found in `terraform.tfvars.example` file.  

Then run:
```bash
cd cloud-init/
terraform init
terraform apply
```

Terraform state will be saved locally


#### Environment

Main package with initialize all infrastructure.

Infrastructure list:

 - Service IAM with access to all used services. Keys for programmatic access are outputed. 
 - VPC with private and public subnets
 - Three security groups - `open` - open all port all IPs, not used by default,
 `public` - open only chosen ports for all IPs (confgiured by variable), 
 `private` - open all ports for listed CIDRs, subnets added by default. Adding new whitelisted IPs should be done in `main.tf` file in `security group` module config. Note: single IP in CIDR form has mask 32 bit. E.g. `172.68.0.15/32`
 - Two instances (Dev and Staging) inside public subnet of VPC.
 - Elastic IP for each instance
 - S3 bucket for each environment
 - Subdomains for each environment which mapped to created elastic IPs. Format: `dev.<project_name>.<domain>`, `staging.<project_name>.<domain>`.

Note: no RDS database created because it mostly not be necessary for the development. 

##### Variables:

General variables:

 - `project_name` - used to create names for resources in format `{project_name}-{resource_name}`. Value should be URL compatible. E.g. `my-superchat-staging`, `my-superchat-vpc`  

AWS general variables: 

 - `aws_region` - bucket AWS region
 - `aws_access_key` - AWS Access Key
 - `aws_secret_key` - AWS Secret Key


Route 53 module variables:

 - `route53_domain_name` - Route53 domain name. Should be with `.` in the end. E.g. `uptech.team.`.


Instance module variables:

 - `dev_instance_ssh_key_path` - path to public key for dev instace. Can be same as for staging.  
 - `staging_instance_ssh_key_path` - path to public key for staging instace. Can be same as for dev.  
 - `dev_instance_volume_size` - disk size for dev instance
 - `staging_instance_volume_size` - disk size for staging instance
 - `instance_ami` - Instances AMI. Expected that dev and staging use same AMI. More about AWS AMIs https://docs.aws.amazon.com/en_us/AWSEC2/latest/UserGuide/AMIs.html
 - `dev_instance_type` - dev instance type
 - `staging_instance_type` - staging instance type


VPC module variables:

 - `vpc_cidr` - VPC CIDR, default `10.0.0.0/26` # More about CIDR: https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing 
 - `vpc_subnets_cidrs` - Map with private and public subnets CIDRs, default `{ public = "10.0.0.0/27", private = "10.0.0.32/27" }`


Security group module variables:

 - `public_ports` - List of ports which will be open in public security group 

More about variables: https://www.terraform.io/docs/configuration/variables.html

##### Usage

`terraform.tfvars` file with following variables should be created. Example can be found in `terraform.tfvars.example` file.  

Terraform state for this packages stored on AWS in the bucket which were created by `cloud-init`, so additional backend configuration required on init. 
Example: https://github.com/hashicorp/terraform/issues/13022#issuecomment-294262392  

Then run:
```bash
cd environment/
terraform init -backend-config="bucket=<cloud-init-output-bucket-name>" -backend-config="region=us-east-1" -backend-config="access_key=<AWS_Access_key>" -backend-config="secret_key=<AWS_Secret_key>"
terraform apply
```
To destroy infrastructure run:
```bash
terraform destroy
```