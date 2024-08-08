resource "null_resource" "run_solution_bucket_presigned_url_script" {
  provisioner "local-exec" {
    command = "sh ${path.module}/../src/scripts/presigned_url.sh"
  }
}
