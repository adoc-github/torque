output "message" {
  value       = module.greeting.message
  sensitive   = false
  description = "My Message"
  depends_on  = []
}

output "url" {
  value       = module.response-url.url
  sensitive   = false
  description = "App URL"
  depends_on  = []
}
