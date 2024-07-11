variable "humanitec_org" {
  description = "The ID of the organization"
  default     = "humanitec"
  type        = string
}

variable "humanitec_token" {
  description = "Token for accessing Humanitec"
  default     = "humanitec"
  type        = string
}

variable "kubeconfig" {
  description = "Kubeconfig used by the Humanitec Agent / terraform"
  type        = string
  default     = "/state/kube/config-internal.yaml"
}
