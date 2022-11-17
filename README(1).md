
# PHP-APPLICATION WITH MONITORNING, AUTO SCALING AND HA

This project is step by step guide to Deploy PHP or any other application in High Availability with MONITORNING

The following content needed to be created and managed:

    >>Introduction
        >Explaination of module
        >Intended users
    >>Resource created and managed by this module
    >>Example Usages

Requirements
    Name 	Version
    terraform 	>= 1.3.0

Providers
    Name    Type
    AWS     RDS, Instance and VPN permissions
Steps:
        $if you have preconfigured AMI you can skip this step
        Create an EC2 Instance for Webserver
            $for this proejct we are using drupal PHP project fill free to use another application and run service on port 80
            >> https://www.tecmint.com/install-drupal-in-ubuntu-debian/ follow these steps
            >> #Preform only step 5 and Step 6 for this link
            >> https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04
            >> Now create an AMI of this Instance manually
            >> This AMI is called slave or Webserver 
        Create an EC2 Instance for Jenkins
        Note: this step is not mandatory
            >> Install Jenkins on this server { https://www.jenkins.io/doc/book/installing/linux/#debianubuntu }
            >> go to Web browser and type http://ip-address:8080
                >follow the required steps then for first time
            >> Create new pipline and paste pipline code from this directory
pipeline {
    agent any

    stages {
        stage('git checkout') {
            steps {
                git branch: 'main', credentialsId: '<change here>', url: '<change here>'
            }
        }
        stage('terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('terraform plan') {
            steps {
                sh 'terraform plan -lock=false'
            }
        }
        stage('terraform apply') {
            steps {
                sh 'terraform apply --auto-approve -lock=false'
            }
        }
    }
}
            >> Make changes in <change here> section
            >> NOTE: GIT USES REPO WHICH CONTAINS OUR TERRAFORM CODE AND MAKE SURE TO DOWNLOAD TERRAFORM PLUGINGS IN Jenkins
            >> In Command line {
                # su jenkins
                # aws configure --profile <Your Name>
                # Exit
            }
            >> Follow https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-grafana-on-ubuntu-18-04
            >> Follow https://www.digitalocean.com/community/tutorials/how-to-install-prometheus-on-ubuntu-16-04
            >> Create an AMI for this instance 
            >> Change your provider configurations in terraform provider.tf 
            >> Copy your web-server AMI and paste it into loadbalancer.tf 
            >> Go to command line and change directory to your terraform code{
                # terraform init
                # terraform plan 
                # terraform apply
            }
            >> This will give you lb-dns-name copy paste it into your browser
            >> Note: make sure your application is showing after this step if not follow step 1 again and change AMI in terraform code
            >> Go to your AWS account 2 Webservers should be running
            >> Launch Instance use master-AMI in project-vpc
            >> Go to command line {
                # sudo nano /etc/prometheus/prometheus.yml
            }
            >> Append {
  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['<web-server-ip>:9100']
            }
            >> NOTE: you can add multiple Webserver using above code
            >> Go to grafana dashboard http://<master-ip>:3000
            >> Add new datasource for http://127.0.0.1:9090


You can always can code push it into github {
    # Go to http:<master-ip>:8080
    # Triger pipline code that we created and changes will be reflected to AWS
}