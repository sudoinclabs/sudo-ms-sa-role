variable "role_name" {
  type        = string
  description = "(optional) Provide the role name"
  default     = "changeme"
}

variable "trusted_role_actions" {
  type        = list(any)
  description = "(optional) Trusted role actions"
  default     = ["sts:AssumeRole"]
}

variable "trusted_role_arns" {
  type        = list(any)
  description = "Trusted role ARNs"
}

variable "default_policy" {
  type        = bool
  description = "(optional) Create default policy. Default: True"
  default     = true
}

variable "principal" {
  type = list(object({
    type        = string
    identifiers = string
  }))
  description = "(optional) list of principals"
  default = [{
    type        = "Service"
    identifiers = "ec2.amazonaws.com"
    }
  ]
}

variable "condition" {
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  description = "(optional) list of conditions"
  default = [{
    test     = "StringEquals"
    variable = "sts:ExternalId"
    values   = ["CHANGEME"]
    }
  ]
}

variable "custom_policy_arns" {
  type        = list(any)
  description = "(optional) Custom Policy ARNs to attach to the role"
  default     = []
}

variable "tags" {
  type        = map(any)
  description = "(optional) specify your custom tags"
  default     = {}
}