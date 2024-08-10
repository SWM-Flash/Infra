resource "null_resource" "run_solution_bucket_presigned_url_script" {
  provisioner "local-exec" {
    command = "sh ${path.module}/../src/scripts/presigned_url.sh"
  }

  triggers = {
    script_hash = filebase64sha256("${path.module}/../src/presigned_url/lambda_function.py")
  }
}

resource "null_resource" "request_transcoding_script" {
  provisioner "local-exec" {
    command = "sh ${path.module}/../src/scripts/request_transcoding.sh"
  }

  triggers = {
    script_hash = filebase64sha256("${path.module}/../src/request_transcoding/lambda_function.py")
  }
}
