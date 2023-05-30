---
title: How to Use AWS
author: ''
date: '2020-07-30'
slug: how-to-use-aws
categories:
  - how_to
tags: []
---

## Im lab's AWS Best Practices

-   Stop/start your EC2 instances programatically through AWS Command Line Interface (CLI).

-   Stop your EC2 instances to avoid incurring charges when not in use.

-   Your secret key must be kept very secret. Please store it in a very safe place and don't include it in your code.

## How to login to your AWS account?

you should have gotten the credentials from the lab's cloud administrator https://hakyimlab.signin.aws.amazon.com/console

Once you login to your account using temporary password, you can reset your password by the following policy: \* Minimum password length (6 to 128). \* Require at least one uppercase letter (A to Z). \* Require at least one lowercase letter (a to z). \* Require at least one number (0 to 9). \* Require at least one nonalphanumeric character (! \@ \# \$ % \^ & \* ( ) \_ + - = \[ \] { } \| ').

## How to manage AWS access and secret keys?

-   Please store your access key ID (something like AKIAIOSFODNN7EXAMPLE) and a secret access key (something like wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY) in a very safe place.
-   Anyone who has your credentials has the same level of access to your AWS resources (e.g. EC2, S3, RDS etc) that you do. So they must be kept very secret. Please never share them with others or include them in your code.

## How to install and upgrade the AWS CLI?

```         
sudo easy_install pip
sudo pip install awscli --ignore-installed six
sudo pip install --upgrade awscli
```

## How to configure the AWS CLI?

```         
aws configure
AWS Access Key ID [None]: <YOUR AWS ACCESS KEY>
AWS Secret Access Key [None]: <YOUR SECRET ACCESS KEY>
Default region name [None]: us-east-1
Default output format [None]: json 
```

## How to launch your EC2 instances through AWS console?

Amazon hosts its resources under different regions, after you login, make sure you are in 'N. Virginia' region, that's where our virtual private clouds are setup.

-   Create ssh key pair

In order to access EC2 resources, you should first load your ssh public key onto amazon, so that VMs will be property configured when you try to launch them. - Click'Services' on the top nav bar,selectEC2. - Select "NETWORK&SECURITY" -\> Key Pairs on the left panel - Click"create key pair" if you want to create new key pair, or load your existing one. Please name your key pair under your username

-   Launch a VM under public VPC

-   Select"Instances"-\>"LaunchInstance" in EC2 dashboard

-   Choose image you want to use

-   Chose an instance type based on your computing needs

-   Configure instance details with those choices, use the default ones if it's not mentioned below:

    -   Network: public Subnet: public subnet
    -   Auto-assign Public IP: enable

-   Click "Review and Launch" ___ Security Groups -\> select an existing security group -\> select 'default' ___ Tags -\> create tag for your instance name: eg: Key: Name, Value: abc

-   Launch with your ssh keypair

-   Launch a VM under private VPC

If you are going to use protected data, launch VMs under the private VPC. VMs launched under this VPC are under private network and do not have public access. This VPC has a public VM called "Login Node". You should ssh onto that VM in order to reach VMs under the private network.

-   Contact administrator to grant you access to login node
-   Launcha VM using the same instruction as for the public VPC, except for choosing those options when configuring instance details:
    -   Network: main
    -   Subnet: private
    -   Auto-assign Public IP: Use subnet setting (Disable) security groups: select 'local'
-   After the VM is running, ssh onto login node,then ssh on to your VM to access it

## How to launch your EC2 instance using Cloudformation through CLI?

-Download and modify the template here @https://s3.amazonaws.com/imlab-jiamaoz/LaunchEC2InstanceUsingCloudformationTemplate.json.

-   Upload your modified template to your bucket in s3
-   Run the following command in the terminal:

```         
aws cloudformation update-stack --stack-name <YOUR STACK NAME> --template-url  https://s3.amazonaws.com/<YOUR BUCKET NAME>/LaunchEC2InstanceUsingCloudformationTemplate.json
```

## How to associate an Elastic IP address to your EC2 instance

```         
aws ec2 associate-address --instance-id <YOUR INSTANCE ID> --public-ip <YOUR ELASTIC IP ADDRESS>
```

## How to peer AWS VPC?

Please follow steps from <a title="AWS: Virtual Private Cloud" href="http://blog.celingest.com/en/2014/05/09/introduction-aws-vpc-peering/" target="_blank">An introduction to AWS VPC Peering</a>

## How to get your Amazon EC2 instance id using AWS CLI?

```         
aws ec2 describe-instances --filters "Name=tag:Name, Values=<YOUR INSTANCE TAG NAME>" --query 'Reservations[0].Instances[0].InstanceId'
```

## How to stop an EC2 instance using AWS CLI?

```         
aws ec2 stop-instances --instance-ids <YOUR INSTANCE ID> --query 'StoppingInstances[0].CurrentState.Name'
```

## How to start an EC2 instance using AWS CLI?

```         
aws ec2 start-instances --instance-ids <YOUR INSTANCE ID> --query 'StartingInstances[0].CurrentState.Name'
```

## How to get the IP address of the running instance using AWS CLI?

```         
aws ec2 describe-instances --instance-ids <YOUR INSTANCE ID> --query 'Reservations[0].Instances[0].PublicIpAddress'
```

## How to automatically stop the instance?

It's highly recommended to create the CloudWatch alarm to stop your instance automatically by default.

```         
aws cloudwatch put-metric-alarm --alarm-name XXXXXX-stop-alarm --alarm-description "Stop the instance when it is idle for one hour" --namespace "AWS/EC2" --dimensions Name=InstanceId,Value="i-XXXXXX" --statistic Maximum --metric-name CPUUtilization --comparison-operator LessThanThreshold --threshold 5 --period 300 --evaluation-periods 12 --alarm-actions arn:aws:automate:us-east-1:ec2:stop --unit Percent
```

Above `put-metric-alarm` command should generate a good CloudWatch alarm that will automatically stop the instance if the maxium CPU utilization of your instance is less than 5% over a hour period. Please replace the values for InstanceID and alarm name with your own values.

If you would like to receive email notification, please use the following `put-metric-alarm` command which includes your SNS topic `arn:aws:sns:us-east-1:215500445195:<YOUR ALARM NAME>`. Please refer `How to set Up Amazon Simple Notification Service?` to set up your SNS topic.

```         
aws cloudwatch put-metric-alarm --alarm-name XXXXXX-stop-alarm --alarm-description "Stop the instance when it is idle for one hour" --namespace "AWS/EC2" --dimensions Name=InstanceId,Value="i-XXXXXX" --statistic Maximum --metric-name CPUUtilization --comparison-operator LessThanThreshold --threshold 5 --period 300 --evaluation-periods 12 --alarm-actions arn:aws:automate:us-east-1:ec2:stop arn:aws:sns:us-east-1:215500445195:<YOUR ALARM NAME> --unit Percent
```

There are three scenarios for stopped instance's CloudWatch alarm .

1)  `No Data` alarm status. If you restart your instance, CloudWatch will work as expected.

2)  `ALARM` alarm status. If you restart your instance AND do some computational work, CloudWatch will work as expected. You will notice that `ALARM` alarm status will disappear and `OK` will appear in a few minutes.

3)  `ALARM` alarm status. If you restart your instance AND don't do any computational work, CloudWatch will `NOT` work as expected. The instance will not automatically stop because the instance alarm status is still `ALARM`, and CloudWatch alarm won't be triggered without any alarm status changes.

Please avoid last scenario. To solve this, please either do some computational work (like scenario 2) or stop your instance and wait for at least 1 hour.

## How to set Up Amazon Simple Notification Service?

1). Create the topic using the create-topic command. You receive a topic resource name as a return value:

```         
aws sns create-topic --name <YOUR ALARM NAME>
```

2). Subscribe your email address to the topic using the subscribe command. You will receive a confirmation email message if the subscription request succeeds.

```         
aws sns subscribe --topic-arn arn:aws:sns:us-east-1:215500445195:<YOUR ALARM NAME> --protocol email --notification-endpoint <YOUR EMAIL ADDRESS>
```

3). Confirm that you intend to receive email from Amazon Simple Notification Service by clicking the confirmation link in the body of the message to complete the subscription process. <br><br> 4). Publish a message directly to the topic using the publish command to ensure that the topic is properly configured.

```         
aws sns publish --message "Verification" --topic arn:aws:sns:us-east-1:215500445195:<YOUR ALARM NAME>
```

5). Check your email to confirm that you received the message from the topic.
