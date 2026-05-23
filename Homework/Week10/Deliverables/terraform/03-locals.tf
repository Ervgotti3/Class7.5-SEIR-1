locals {
  name_prefix = "${var.name_prefix}-${var.region}"
  web_tag     = "${local.name_prefix}-web"
}