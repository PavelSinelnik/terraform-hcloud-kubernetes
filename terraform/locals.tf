locals {
  rules_kuber = [
    {
      description = "Ping ICMP"
      direction   = "in"
      protocol    = "icmp"
      source_ips  = ["0.0.0.0/0"]
    },
    {
      description = "SSH"
      direction   = "in"
      protocol    = "tcp"
      port        = 22
      source_ips  = ["0.0.0.0/0"]
    },
    {
      description = "HTTP"
      direction   = "in"
      protocol    = "tcp"
      port        = 80
      source_ips  = ["0.0.0.0/0"]
    },
    {
      description = "Loki"
      direction   = "in"
      protocol    = "tcp"
      port        = 6443
      source_ips  = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS"
      direction   = "in"
      protocol    = "tcp"
      port        = 443
      source_ips  = ["0.0.0.0/0"]
    }
  ]
}