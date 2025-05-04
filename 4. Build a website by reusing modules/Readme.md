## Steps to build website by using terraform

**1\. Create a Directory**
- Create a directory for the Terraform files
```bash
  mkdir terraform-web
  cd terraform-web
```

**2\. Create the terraform files**

- Kindly check main, Providers, Variables, terraform.tfvars, Output, install_space_invaders.sh files

**3\. Deploy the VM**

- Initialize Terraform
```bash
terraform init
```

- Plan the infrastructure
```bash
terraform plan
```

- Apply the configuration
```bash
terraform apply
```

- Destroy the infrastructure
```bash
terraform destroy
```
