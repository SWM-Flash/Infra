resource "aws_iam_role" "lambda_mediaconvert_fullaccess_role" {
  name = "LambdaMediaConvertRole-${var.env_name}"

  assume_role_policy = jsonencode({
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
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_policy" {
  role       = aws_iam_role.lambda_mediaconvert_fullaccess_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda에 S3 전체 접근 권한을 부여하는 정책 첨부
resource "aws_iam_role_policy_attachment" "lambda_s3_full_access_policy" {
  role       = aws_iam_role.lambda_mediaconvert_fullaccess_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "mediaconvert_full_access_policy" {
	role       = aws_iam_role.lambda_mediaconvert_fullaccess_role.name
	policy_arn = "arn:aws:iam::aws:policy/AWSElementalMediaConvertFullAccess"
}
