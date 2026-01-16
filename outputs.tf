output "instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the EC2 instance"
}

output "app_url" {
  value       = "http://${aws_instance.web.public_ip}:5000"
  description = "URL of the Python application"
}
