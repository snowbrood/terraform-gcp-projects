locals {
  instance_names = ["one", "two", "three"]
  
  instance_tags = {
    one   = "First Instance"
    two   = "Second Instance"
    three = "Third Instance"
  }
}

resource "null_resource" "example_count" {
  count = length(local.instance_names)
  
  triggers = {
    name = local.instance_names[count.index]
  }
}

resource "null_resource" "example_for_each" {
  for_each = local.instance_tags
  
  triggers = {
    name = each.key
    tag  = each.value
  }
}

output "count_instance_triggers" {
  value = null_resource.example_count[*].triggers
  description = "The triggers of the example instances created with count."
}

output "for_each_instance_triggers" {
  value = { for k, v in null_resource.example_for_each : k => v.triggers }
  description = "The triggers of the example instances created with for_each."
}
