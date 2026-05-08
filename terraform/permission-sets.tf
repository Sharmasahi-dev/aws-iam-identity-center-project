data "aws_ssoadmin_instances" "current" {}

# Developer Permission Set
resource "aws_ssoadmin_permission_set" "developer_access" {
  name             = "DeveloperAccess"
  description      = "Developer limited access"
  instance_arn     = data.aws_ssoadmin_instances.current.arns[0]
  session_duration = "PT4H"
}

# Read Only Permission Set
resource "aws_ssoadmin_permission_set" "readonly_access" {
  name             = "ReadOnlyAccess"
  description      = "Read only access"
  instance_arn     = data.aws_ssoadmin_instances.current.arns[0]
  session_duration = "PT4H"
}

# Admin Permission Set
resource "aws_ssoadmin_permission_set" "admin_access" {
  name             = "AdminAccess"
  description      = "Administrator access"
  instance_arn     = data.aws_ssoadmin_instances.current.arns[0]
  session_duration = "PT8H"
}
# Developer Policy Attachment
resource "aws_ssoadmin_managed_policy_attachment" "developer_policy" {
  instance_arn       = data.aws_ssoadmin_instances.current.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.developer_access.arn

  managed_policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# ReadOnly Policy Attachment
resource "aws_ssoadmin_managed_policy_attachment" "readonly_policy" {
  instance_arn       = data.aws_ssoadmin_instances.current.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.readonly_access.arn

  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Admin Policy Attachment
resource "aws_ssoadmin_managed_policy_attachment" "admin_policy" {
  instance_arn       = data.aws_ssoadmin_instances.current.arns[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin_access.arn

  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}