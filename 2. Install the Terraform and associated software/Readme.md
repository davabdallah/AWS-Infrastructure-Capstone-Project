# Install software

**1\. Install Terraform**

- Install the terraform by running the below commands  
```bash
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

- You can verify the installation by running the below command
```bash
terraform --version
```

**2\. Configure EC2 as the deployment server**

- You must have access and secret keys and add them into AWS configuration by running the below  
```bash
aws configure
```
- Enter the AWS Access Key.
- Enter the AWS Secret Access Key.
- Enter the Default region us-east-1
- For Default output format, enter json, then press ENTER.
