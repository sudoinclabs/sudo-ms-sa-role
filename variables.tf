variable "role_name" {
  type = string
  description = "(optional) Provide the role name"
  default = "changeme"
}

variable "trusted_role_actions" {
  type = list
  description = "(optional) Trusted role actions"
  default = [ "sts:AssumeRole" ]
}

variable "trusted_role_arns" {
  type = list
  description = "Trusted role ARNs"
}

variable "condition" {
  type = list(object({
    test = string
    variable = string
    values = list(string)
  }))
  description = "(optional) list of conditions"
  default = [{
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["CHANGEME"]
    }
  ]
}