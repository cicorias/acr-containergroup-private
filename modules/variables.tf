variable "diagnostic_name" {
  type        = string
  description = "The name of the diagnostic setting."
  default     = "spc-diag"
}

variable "target_resource_id" {
  type        = string
  description = "The resource ID of the resource to apply the diagnostic setting to."
  default     = ""
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The resource ID of the Log Analytics workspace to send the diagnostic logs to."
  default     = ""
}

variable "diag_logs" {
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  # default = null
  default = [
    {
      category          = "ContainerRegistryRepositoryEvents"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    },
    {
      category          = "ContainerRegistryLoginEvents"
      enabled           = true
      retention_enabled = true
      retention_days    = 30
    }
  ]
}

variable "diag_metrics" {
  type = set(object({
    category          = string
    enabled           = bool
    retention_enabled = bool
    retention_days    = number
  }))
  default = [{
    category          = "AllMetrics"
    enabled           = true
    retention_days    = 30
    retention_enabled = true
  }]
}
