output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "Public URL for the application"
}

