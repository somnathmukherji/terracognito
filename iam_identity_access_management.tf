resource "aws_iam_access_key" "akiayqywfx3zdh5t7viz" {
  status = "Active"
  user   = aws_iam_user.somnathdevops.name
}

resource "aws_iam_group" "devops" {
  name = "Devops"
  path = aws_iam_policy.arn_aws_iam__585772678898_policy_allow_ec2_access.path
}

resource "aws_iam_group_membership" "devops" {
  group = "Devops"
  name  = ""
  users = ["somnathdevops"]
}

resource "aws_iam_group_policy_attachment" "devops_arn_aws_iam__aws_policy_administratoraccess" {
  group      = aws_iam_group.devops.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "ec2_access" {
  name = "EC2_Access"
  path = "/"
  role = "EC2_Access"
}

resource "aws_iam_policy" "arn_aws_iam__585772678898_policy_allow_ec2_access" {
  tags = {
    Role = "EC2"
  }

  tags_all = {
    Role = "EC2"
  }

  description = "ALLOW to launch EC2 Access"
  name        = "ALLOW_EC2_ACCESS"
  path        = "/"
  policy      = "{\"Statement\":[{\"Action\":[\"ec2:*\"],\"Effect\":\"Allow\",\"Resource\":\"*\"},{\"Action\":\"iam:PassRole\",\"Effect\":\"Allow\",\"Resource\":\"arn:aws:iam::123456789012:role/*\"}],\"Version\":\"2012-10-17\"}"
}

resource "aws_iam_role" "awsserviceroleforapplicationautoscaling_dynamodbtable" {
  assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"dynamodb.application-autoscaling.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  inline_policy {
  }

  managed_policy_arns  = ["arn:aws:iam::aws:policy/aws-service-role/AWSApplicationAutoscalingDynamoDBTablePolicy"]
  max_session_duration = 3600
  name                 = "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"
  path                 = "/aws-service-role/dynamodb.application-autoscaling.amazonaws.com/"
}

resource "aws_iam_role" "awsserviceroleforsupport" {
  assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"support.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  description        = "Enables resource access for AWS to provide billing, administrative and support services"
  inline_policy {
  }

  managed_policy_arns  = ["arn:aws:iam::aws:policy/aws-service-role/AWSSupportServiceRolePolicy"]
  max_session_duration = 3600
  name                 = "AWSServiceRoleForSupport"
  path                 = "/aws-service-role/support.amazonaws.com/"
}

resource "aws_iam_role" "awsservicerolefortrustedadvisor" {
  assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"trustedadvisor.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  description        = "Access for the AWS Trusted Advisor Service to help reduce cost, increase performance, and improve security of your AWS environment."
  inline_policy {
  }

  managed_policy_arns  = ["arn:aws:iam::aws:policy/aws-service-role/AWSTrustedAdvisorServiceRolePolicy"]
  max_session_duration = 3600
  name                 = "AWSServiceRoleForTrustedAdvisor"
  path                 = "/aws-service-role/trustedadvisor.amazonaws.com/"
}

resource "aws_iam_role" "ec2_access" {
  assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  description        = "Allows EC2 instances to call AWS services on your behalf."
  inline_policy {
  }

  managed_policy_arns  = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
  max_session_duration = 3600
  name                 = "EC2_Access"
  path                 = "/"
}

resource "aws_iam_role" "somnathterraformaccess" {
  assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::585772678898:root\"},\"Action\":\"sts:AssumeRole\",\"Condition\":{\"StringEquals\":{\"sts:ExternalId\":\"somnathterraform\"}}}]}"
  description        = "access rights to somnath to access terraform"
  inline_policy {
  }

  managed_policy_arns  = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  max_session_duration = 3600
  name                 = "somnathterraformaccess"
  path                 = aws_iam_policy.arn_aws_iam__585772678898_policy_allow_ec2_access.path
}

resource "aws_iam_role_policy_attachment" "awsserviceroleforapplicationautoscaling_dynamodbtable_arn_aws_iam__aws_policy_aws_service_role_awsapplicationautoscalingdynamodbtablepolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSApplicationAutoscalingDynamoDBTablePolicy"
  role       = aws_iam_role.awsserviceroleforapplicationautoscaling_dynamodbtable.id
}

resource "aws_iam_role_policy_attachment" "awsserviceroleforsupport_arn_aws_iam__aws_policy_aws_service_role_awssupportservicerolepolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSSupportServiceRolePolicy"
  role       = aws_iam_role.awsserviceroleforsupport.id
}

resource "aws_iam_role_policy_attachment" "awsservicerolefortrustedadvisor_arn_aws_iam__aws_policy_aws_service_role_awstrustedadvisorservicerolepolicy" {
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AWSTrustedAdvisorServiceRolePolicy"
  role       = aws_iam_role.awsservicerolefortrustedadvisor.name
}

resource "aws_iam_role_policy_attachment" "ec2_access_arn_aws_iam__aws_policy_amazonec2fullaccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.ec2_access.id
}

resource "aws_iam_role_policy_attachment" "somnathterraformaccess_arn_aws_iam__aws_policy_administratoraccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.somnathterraformaccess.id
}

resource "aws_iam_user" "somnathdevops" {
  tags = {
    AKIAYQYWFX3ZDH5T7VIZ = "Programmatically Access"
  }

  tags_all = {
    AKIAYQYWFX3ZDH5T7VIZ = "Programmatically Access"
  }

  name = "somnathdevops"
  path = aws_iam_policy.arn_aws_iam__585772678898_policy_allow_ec2_access.path
}

resource "aws_iam_user_policy_attachment" "somnathdevops_arn_aws_iam__585772678898_policy_allow_ec2_access" {
  policy_arn = aws_iam_policy.arn_aws_iam__585772678898_policy_allow_ec2_access.arn
  user       = aws_iam_user.somnathdevops.id
}

