## Steps to Deploy a VM by using terraform

**1\. Create a Directory**
- Create a directory for the Terraform files
```bash
  mkdir terraform-vm
  cd terraform-vm
```

**2\. Create the terraform files**

- Create main file, Providers file, Variables file, terraform.tfvars file Output file, all files in this repo

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
