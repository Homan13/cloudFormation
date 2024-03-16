# Wordpress Two Tier

A collection of CloudFormation templates that provision the entire stack; network, web and data tiers to run Wordpress a Wordpress site. These templates are meant to be used similar fashion to my Single Instance Wordpress project for learning and instructional purposes and is not meant to be used in a production setting. These templates serve as the natural "next step" taking the single instance running both Wordpress and the database, and decoupling those two components providing greater resiliency. Additionally, nested stacks are introduced, breaking out the individual components of the template into their own template, managed by a parent template. By breaking out the components into their own stacks, we are able to increase the reusability of the various templates we develope as well as make our templates more maintainable by keeping them of a manageble size.

## Getting Started

This repository contains the following project directories;

**wordpress-2tier-al2** - This stack will launch a single Amazon Linux 2 (AL2) Elastic Compute Cloud (EC2) instance that runs your web tier (Apache, PHP and Wordpress) and a single Amazon Relational Database Service (RDS) instance that runs your datbase tier. Additionally, a new VPC with associated internet gateway, public and private subnets, route tables and security groups will be created that stack resources will be launched into. This stack is currently running the following software versions; Wordpress 6.4.x, Apache 2.4.x, MariaDB 10.11.x and PHP 8.2.x.

**wordpress-2tier-al2023** - This stack will launch a single Amazon Linux 2023 (AL2023) Elastic Compute Cloud (EC2) instance that runs your web tier (Apache, PHP and Wordpress) and a single Amazon Relational Database Service (RDS) instance that runs your datbase tier. Additionally, a new VPC with associated internet gateway, public and private subnets, route tables and security groups will be created that stack resources will be launched into. This stack is currently running the following software versions; Wordpress 6.4.x, Apache 2.4.x, MariaDB 10.5.x and PHP 8.2.x.

**wordpress-2tier-rhel** - This stack will launch a single Amazon Linux 2023 (AL2023) Elastic Compute Cloud (EC2) instance that runs your web tier (Apache, PHP and Wordpress) and a single Amazon Relational Database Service (RDS) instance that runs your datbase tier. Additionally, a new VPC with associated internet gateway, public and private subnets, route tables and security groups will be created that stack resources will be launched into. This stack is currently running the following software versions; Wordpress 6.4.x, Apache 2.4.x, MariaDB 10.5.x and PHP 8.2.x.

**wordpress-2-tier-ubuntu** - This stack will launch a single Ubuntu 22.04 Elastic Compute Cloud (EC2) instance that runs your web tier (Apache, PHP and Wordpress) and a single Amazon Relational Database Service (RDS) instance that runs your datbase tier. Additionally, a new VPC with associated internet gateway, public and private subnets, route tables and security groups will be created that stack resources will be launched into. This stack is currently running the following software versions; Wordpress 6.4.x, Apache 2.4.x, MariaDB 10.11.x and PHP 8.2.x.

### Prerequisites

All you need to get started with these templates is an AWS account with access to the CloudFormation console and permissions to launch new CloudFormation stacks.

## System Architecture

Coming soon

## Deployment

Coming soon

## Built With

* [Amazon EC2](https://aws.amazon.com/ec2/)
* [Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/?amazon-linux-whats-new.sort-by=item.additionalFields.postDateTime&amazon-linux-whats-new.sort-order=desc)
* [Amazon RDS](https://aws.amazon.com/rds/)
* [Amazon VPC](https://aws.amazon.com/vpc/)
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

**mada0007** - [cloud_wordpress](https://github.com/mada0007/cloud_wordpress) - I was initially having some difficulty in getting Wordpress to connect to the RDS database. After reviewing this repository, I realized that I just needed to make a slight reconfiguration of my database credentials configuration within my cfn_init section

**jquiossoto** - [wordpress-multisite-ecs-efs-rds](https://github.com/jquirossoto/wordpress-multisite-ecs-efs-rds) - This repository helped me get passed a blocker on launching RDS, specifically a failure to associate my security group to the database instance