# ALB example

Configuration in this directory creates Aurora MySQL database. 

## Usage

To run this example you need to execute:

```hcl
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run terraform destroy when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.33.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ./../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_cluster_endpoint"></a> [aurora\_cluster\_endpoint](#output\_aurora\_cluster\_endpoint) | description |
| <a name="output_aurora_cluster_endpoint_port"></a> [aurora\_cluster\_endpoint\_port](#output\_aurora\_cluster\_endpoint\_port) | description |
| <a name="output_aws_rds_cluster_password"></a> [aws\_rds\_cluster\_password](#output\_aws\_rds\_cluster\_password) | The database password |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->