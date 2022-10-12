module "greeting" {
  source = "./common/greeting"
  my_name = var.my_name
}

module "response-url" {
  source = "./common/response-url"
}
