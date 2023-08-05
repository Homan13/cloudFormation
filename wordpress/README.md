# Wordpress

A collection of CloudFormation templates to provision and manage Wordpress on AWS. These templates range from the simple (single EC2 instance) for an engineer just getting started on AWS and/or Wordpress to (eventually) templates for enterprise and serverless deployments of Wordpress.

## Getting Started

This repository contains the following projects;

**SingleInstanceWordpress** - This project contains templates to launch a single Elastic Compute Cloud (EC2) instance and configure a Wordpress enabled LAMP stack as a web server and database serving up the site. Currently includes templates for Amazon Linux 2 (AL2), Amazon Linux 2023 (AL2023), Red Hat Enterprise Linux (RHEL) 9 and Ubuntu 22.04 with more to come. These templates are meant to be used for anyone looking to familiarize themselves with automated provisioning of Wordpress infrastructure in AWS using CloudFormation.

**wordpress-2tier** - This project contains templates to launch an Amazon Virtual Private Cloud (VPC) and a two-tier Wordpress stack with Wordpress running on EC2, and the database tier running on Relational Database Service (RDS) in AWS. Currently includes templates for AL2, AL2023, RHEL 9 and Ubuntu 22.04 with more to come. Similar to the SingleInstanceWordpress template's, these templates are meant to be used to familiarize yourself with the concept of splitting up your web and database tiers creating a more resilient architecture. I do not recommend using these for production level deployments.

These templates should be ready to launch with no changes required. Just download, and either store on your local system or in an S3 bucket. They can then be run directly from the CloudFormation console pointing at whichever location you've decided to run them from.

To get started, use the README within the individual project directories to launch a particular stack.