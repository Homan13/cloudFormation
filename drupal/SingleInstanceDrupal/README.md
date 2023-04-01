# Single Instance Drupal

A collection of CloudFormation templates to provision and manage Drupal on a single Amazon Elastic Compute Cloud (EC2) instance. These templates are meant to be used as a learning tool helping someone learn how to use CloudFormation to automate the provisioning and management of Drupal infrastructure in AWS. Since these templates only use a single instance for web-server and database they are not intended to run production Wordpress workloads. *Please Note* - may not work on Chrome. If Drupal setup does not run properly, and you're running it from Chrome, try again and use Firefox.

## Getting Started

This repository contains the following projects;

**cf-drupal-singleinstance-al2.yaml** - This template will launch a single Amazon Linux 2 (AL2) Elastic Compute Cloud (EC2) instance and configure a Drupal enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Drupal 10.0.x, Apache 2.4.x, MariaDB 10.5.x and PHP 8.1.x.

**cf-drupal-singleinstance-al2023.yaml** - This template will launch a single Amazon Linux 2023 (AL2023) Elastic Compute Cloud (EC2) instance and configure a Drupal enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Drupal 10.0.x, Apache 2.4.x, MariaDB 10.5.x, and PHP 8.1.x.

**cf-drupal-singleinstance-rhel.yaml** - This template will launch a single Red Hat Enterprise Linux (RHEL) 9 Elastic Compute Cloud (EC2) instance and configure a Drupal enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Drupal 10.0.x, Apache 2.4.x, MariaDB 10.6.x and PHP 8.1.x.

**cf-drupal-singleinstance-ubuntu.yaml** - This template will launch a single Ubuntu 22.04 Elastic Compute Cloud (EC2) instance and configure a Drupal enabled LAMP stack as a web server and database serving up the site. This stack is running the following software versions; Drupal 10.0.x, Apache 2.4.x, MariaDB 10.6.x and PHP 8.1.x.

### Prerequisites

All you need to get started with these templates is an AWS account with access to the CloudFormation console and permissions to launch new CloudFormation stacks.

## Deployment

Coming soon

## Built With

* [Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/?amazon-linux-whats-new.sort-by=item.additionalFields.postDateTime&amazon-linux-whats-new.sort-order=desc)
* [Apache](https://httpd.apache.org/)
* [Bash](https://www.gnu.org/software/bash/)
* [CloudFormation](https://docs.aws.amazon.com/cloudformation/index.html)
* [Drupal](https://www.drupal.org/)
* [MariaDB](https://mariadb.org/)
* [PHP](https://www.php.net/)
* [Red Hat Enterprise Linux](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux)
* [Ubuntu](https://ubuntu.com/)

## Contributing

Coming soon

## Versioning

Coming Soon

## Authors

* **Kevin Homan**

## License

Coming Soon