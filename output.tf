output "ip_address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "Port and IP Address of Container"
  sensitive   = true
}


output "container_name" {
  value       = docker_container.nodered_container[*].name
  description = "Name of Container1"
}