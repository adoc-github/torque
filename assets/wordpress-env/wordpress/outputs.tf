# インスタンスにアクセスするためのURLを出力
output "instance_url" {
  value = "http://${aws_instance.example.public_ip}"
}
