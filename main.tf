data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "iam_assume_policy_sudo_ms_sa" {
  statement {

    actions = var.trusted_role_actions

    effect = "Allow"

    dynamic "principals" {
      for_each = var.principals
      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }
    dynamic "condition" {
      for_each = var.condition
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

resource "aws_iam_role_policy_attachment" "user_defined_policies" {
  count      = length(var.custom_policy_arns)
  role       = aws_iam_role.iam_role_sudo_ms_sa.name
  policy_arn = var.custom_policy_arns[count.index]
}


resource "aws_iam_role" "iam_role_sudo_ms_sa" {
  name               = var.role_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.iam_assume_policy_sudo_ms_sa.json
  tags               = var.tags
}
resource "aws_iam_role_policy_attachment" "iam_policy_attachment_sudo_ms_sa" {
  count      = length(var.custom_policy_arns) == 0 && var.default_policy ? 1 : 0
  role       = aws_iam_role.iam_role_sudo_ms_sa.name
  policy_arn = aws_iam_policy.iam_policy_sudo_ms_sa[0].arn
}

resource "aws_iam_policy" "iam_policy_sudo_ms_sa" {
  count  = length(var.custom_policy_arns) == 0 && var.default_policy ? 1 : 0
  name   = "${var.role_name}-policy"
  policy = data.aws_iam_policy_document.iam_policy_sudo_ms_sa.json
}


data "aws_iam_policy_document" "iam_policy_sudo_ms_sa" {
  statement {
    sid       = "sudomssarole"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "autoscaling:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "config:BatchGet*",
      "config:List*",
      "config:Select*",
      "ec2:describeregions",
      "ec2:DescribeSubnets",
      "ec2:describevpcendpoints",
      "ec2:DescribeVpcs",
      "iam:*",
      "s3:GetBucketPolicy",
      "s3:GetBucketTagging",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:PutBucketPolicy",
      "s3:PutBucketTagging",
      "sns:GetTopicAttributes",
      "sns:ListTagsForResource",
      "sns:ListTopics",
      "sns:SetTopicAttributes",
      "sns:TagResource",
      "sns:UnTagResource",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListQueues",
      "sqs:ListQueueTags",
      "sqs:SetQueueAttributes",
      "sqs:TagQueue",
      "sqs:UntagQueue",
    ]
  }

}