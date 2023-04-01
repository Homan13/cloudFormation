# Single Instance Wordpress

A collection of CloudFormation templates to provision and manage Wordpress on a single Amazon Elastic Compute Cloud (EC2) instance. These templates are meant to be used as a learning tool helping someone learn how to use CloudFormation to automate the provisioning and management of Wordpress infrastructure in AWS. Since these templates only use a single instance for web-server and database they are not intended to run production Wordpress workloads.

## Getting Started

This repository contains the following projects;

**cf-wordpress-singleinstance-al2.yaml** - This template will launch a single Amazon Linux 2 (AL2) Elastic Compute Cloud (EC2) instance and configure a Wordpress enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Wordpress 6.1.x, Apache 2.4.x, MariaDB 10.5.x and PHP 8.1.x.

**cf-wordpress-singleinstance-al2023.yaml** - This template will launch a single Amazon Linux 2023 (AL2023) Elastic Compute Cloud (EC2) instance and configure a Wordpress enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Wordpress 6.1.x, Apache 2.4.x, MariaDB 10.6.x and PHP 8.1.x.

**cf-wordpress-singleinstance-rhel.yaml** - This template will launch a single Red Hat Enterprise Linux (RHEL) 9 Elastic Compute Cloud (EC2) instance and configure a Wordpress enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Wordpress 6.1.x, Apache 2.4.x, MariaDB 10.6.x and PHP 8.1.x.

**cf-wordpress-singleinstance-ubuntu.yaml** - This template will launch a single Ubuntu 22.04 Elastic Compute Cloud (EC2) instance and configure a Wordpress enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Wordpress 6.1.x, Apache 2.4.x, MariaDB 10.6.x and PHP 8.1.x.

### Prerequisites

All you need to get started with these templates is an AWS account with access to the CloudFormation console and permissions to launch new CloudFormation stacks.

## Deployment

Coming soon

## Built With

* [Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/?amazon-linux-whats-new.sort-by=item.additionalFields.postDateTime&amazon-linux-whats-new.sort-order=desc)
* [Apache](https://httpd.apache.org/)
* [Bash](https://www.gnu.org/software/bash/)
* [CloudFormation](https://docs.aws.amazon.com/cloudformation/index.html)
* [MariaDB](https://mariadb.org/)
* [PHP](https://www.php.net/)
* [Red Hat Enterprise Linux](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux)
* [Ubuntu](https://ubuntu.com/)
* [Wordpress](https://wordpress.com/)

## Contributing

Coming soon

## Versioning

Coming Soon

## Authors

* **Kevin Homan**

## License

Coming Soon

## Acknowledgment

**AWS Premium Support** - [Install AWS CloudFormation helper scripts on Ubuntu 16.04 LTS, Ubuntu 18.04 LTS, Ubuntu 20.04 LTS, Ubuntu 22.04 LTS, and RHEL 9 Amazon Machine Images (AMIs)](https://aws.amazon.com/premiumsupport/knowledge-center/install-cloudformation-scripts/) - Help getting CloudFormation helper scripts running on RHEL and Ubuntu templates

**schoudhary22** [wordpress](https://github.com/schoudhary22/wordpress/blob/master/Test-HA-WP.yml) - Used this template to guide me through configuring cfn-init for these templates

**Stelligent** -[wordpress-nginx](https://github.com/stelligent/cloudformation_templates/blob/master/labs/wordpress/wordpress-nginx.yml) - Used this template to guide me through configuring cfn-init for these templates
