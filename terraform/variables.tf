variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "codecraft-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "codecraft-aks"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "codecraft"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Size of the VM for the node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "codecraftacr"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "CodeCraft"
  }
} 