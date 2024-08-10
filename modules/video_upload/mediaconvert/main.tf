resource "aws_media_convert_queue" "solution_video_queue" {
  name = "${var.env_name} Solution Video Default Queue"
  description = "${var.env_name} Default MediaConvert Queue"
  pricing_plan = "ON_DEMAND"
  status = "ACTIVE"
}
