resource "aws_cloudwatch_event_rule" "mediaconvert_job_complete_rule" {
  name        = "MediaConvertJobCompleteRule-${var.env_name}"
  description = "MediaConvert의 작업이 COMPLETE로 변할 때 트리거"

  event_pattern = jsonencode({
    "source": ["aws.mediaconvert"],
    "detail-type": ["MediaConvert Job State Change"],
    "detail": {
      "status": ["COMPLETE"],
      "queue": [var.mediaconvert_queue_arn]
    }
  })
}

resource "aws_cloudwatch_event_target" "mediaconvert_job_complete_target" {
  rule      = aws_cloudwatch_event_rule.mediaconvert_job_complete_rule.name
  target_id = "InvokeCreateSolutionLambda"
  arn       = var.create_solution_lambda_function_arn
}
