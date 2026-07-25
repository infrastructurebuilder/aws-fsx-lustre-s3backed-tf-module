output "fs_id" {
  description = "The ID of the FSx file system."
  value       = aws_fsx_lustre_file_system.main.id
}

output "dns_name" {
  description = "The DNS name used to mount the file system."
  value       = aws_fsx_lustre_file_system.main.dns_name
}

output "mount_name" {
  description = "The name used in the mount command."
  value       = aws_fsx_lustre_file_system.main.mount_name
}

output "security_group_id" {
  description = "The ID of the security group created for the file system."
  value       = aws_security_group.fsx_sg.id
}