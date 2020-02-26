data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_user.user.arn}"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_iam_role" "lambda" {
    name = "slack_newsletter_lambda"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_lambda_function" "lambda" {
    filename      = "${var.source_path}"
    function_name = "${var.function_name}"
    role          = "${aws_iam_role.lambda.arn}"
    handler       = "${var.handler}"
    runtime       = "${var.runtime}"
    timeout       = "${var.timeout}"

    environment {
      variables = {
        S3_BUCKET = var.bucket
      }
    }
}

output "function_arn" {
  value = "${aws_lambda_function.lambda.qualified_arn}"
}