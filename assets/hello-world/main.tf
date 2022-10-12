module "greeting" {
  source = "./greeting"
  my_name = var.my_name
}

module "response-url" {
  source = "./response-url"
}
