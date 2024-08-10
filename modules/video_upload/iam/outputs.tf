output "mediaconvert_role_arn" {
	value = aws_iam_role.mediaconvert_role.arn
}

output "lambda_mediaconvert_role_arn" {
	value = aws_iam_role.lambda_mediaconvert_fullaccess_role.arn
}
