variable "cluster_name" {
  type        = string
  description = "Unique cluster name (prepended to dns_zone)"
}

# AWS

variable "dns_zone" {
  type        = string
  description = "AWS Route53 DNS Zone (e.g. aws.example.com)"
}

variable "dns_zone_id" {
  type        = string
  description = "AWS Route53 DNS Zone ID (e.g. Z3PAABBCFAKEC0)"
}

# instances

variable "controller_count" {
  type        = string
  default     = "1"
  description = "Number of controllers (i.e. masters)"
}

variable "worker_count" {
  type        = string
  default     = "1"
  description = "Number of workers"
}

variable "controller_type" {
  type        = string
  default     = "t3.small"
  description = "EC2 instance type for controllers"
}

variable "worker_type" {
  type        = string
  default     = "t3.small"
  description = "EC2 instance type for workers"
}

variable "os_image" {
  type        = string
  default     = "coreos-stable"
  description = "AMI channel for a Container Linux derivative (coreos-stable, coreos-beta, coreos-alpha, flatcar-stable, flatcar-beta, flatcar-alpha)"
}

variable "disk_size" {
  type        = string
  default     = "40"
  description = "Size of the EBS volume in GB"
}

variable "disk_type" {
  type        = string
  default     = "gp2"
  description = "Type of the EBS volume (e.g. standard, gp2, io1)"
}

variable "disk_iops" {
  type        = string
  default     = "0"
  description = "IOPS of the EBS volume (e.g. 100)"
}

variable "worker_price" {
  type        = string
  default     = ""
  description = "Spot price in USD for autoscaling group spot instances. Leave as default empty string for autoscaling group to use on-demand instances. Note, switching in-place from spot to on-demand is not possible: https://github.com/terraform-providers/terraform-provider-aws/issues/4320"
}

variable "worker_target_groups" {
  type        = list(string)
  description = "Additional target group ARNs to which worker instances should be added"
  default     = []
}

variable "controller_clc_snippets" {
  type        = list(string)
  description = "Controller Container Linux Config snippets"
  default     = []
}

variable "worker_clc_snippets" {
  type        = list(string)
  description = "Worker Container Linux Config snippets"
  default     = []
}

# configuration

variable "ssh_authorized_key" {
  type        = string
  description = "SSH public key for user 'core'"
}

variable "asset_dir" {
  description = "Path to a directory where generated assets should be placed (contains secrets)"
  type        = string
}

variable "networking" {
  description = "Choice of networking provider (calico or flannel)"
  type        = string
  default     = "calico"
}

variable "network_mtu" {
  description = "CNI interface MTU (applies to calico only). Use 8981 if using instances types with Jumbo frames."
  type        = string
  default     = "1480"
}

variable "host_cidr" {
  description = "CIDR IPv4 range to assign to EC2 nodes"
  type        = string
  default     = "10.0.0.0/16"
}

variable "pod_cidr" {
  description = "CIDR IPv4 range to assign Kubernetes pods"
  type        = string
  default     = "10.2.0.0/16"
}

variable "service_cidr" {
  description = <<EOD
CIDR IPv4 range to assign Kubernetes services.
The 1st IP will be reserved for kube_apiserver, the 10th IP will be reserved for coredns.
EOD


  type = string
  default = "10.3.0.0/16"
}

variable "cluster_domain_suffix" {
  description = "Queries for domains with the suffix will be answered by coredns. Default is cluster.local (e.g. foo.default.svc.cluster.local) "
  type = string
  default = "cluster.local"
}

variable "enable_reporting" {
  type = string
  description = "Enable usage or analytics reporting to upstreams (Calico)"
  default = "false"
}

variable "enable_aggregation" {
  description = "Enable the Kubernetes Aggregation Layer (defaults to false)"
  type = string
  default = "false"
}

