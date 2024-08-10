resource "null_resource" "run_solution_bucket_presigned_url_script" {
  provisioner "local-exec" {
    command = "sh ${path.module}/../src/scripts/presigned_url.sh"
  }
}

resource "null_resource" "request_transcoding_script" {
  provisioner "local-exec" {
    command = "sh ${path.module}/../src/scripts/request_transcoding.sh"
  }
}
