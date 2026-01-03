# terraform-plan-changes-count
Action to count changes in `terraform plan`

[![Latest Version](https://img.shields.io/github/v/release/sue445/terraform-plan-changes-count)](https://github.com/sue445/terraform-plan-changes-count/releases)
[![test](https://github.com/sue445/terraform-plan-changes-count/actions/workflows/test.yml/badge.svg)](https://github.com/sue445/terraform-plan-changes-count/actions/workflows/test.yml)

## Requirements
Following command are required to use this action.

* `jq`
* `terraform`
  * e.g. https://github.com/hashicorp/setup-terraform

## Usage
```yml
- uses: sue445/terraform-plan-changes-count@v0
  with:
    # Path to plan report file.
    # Pass same path as the one provided in `terraform plan -out`.
    plan-path: "/path/to/plan-report"

    # Working directory to running terraform command
    # Default: github.workspace
    working-directory: ""
```

## Outputs
* `create` : Count of create resources in `plan-path`
* `update` : Count of update resources in `plan-path`
* `delete` : Count of delete resources in `plan-path`
* `total` : Count of total resources in `plan-path` (same to `create` + `update` + `delete`)

## Example
```yml
steps:
  - uses: hashicorp/setup-terraform@v3

  - run: terraform plan -out=tfplan

  - name: Run terraform-plan-changes-count
    id: plan-changes
    uses: sue445/terraform-plan-changes-count@v0
    with:
      plan-path: tfplan

  - name: Print outputs
    run: |
      echo "CREATE_COUNT=${CREATE_COUNT}"
      echo "UPDATE_COUNT=${UPDATE_COUNT}"
      echo "DELETE_COUNT=${DELETE_COUNT}"
      echo "TOTAL_COUNT=${TOTAL_COUNT}"
    env:
      CREATE_COUNT: ${{ steps.plan-changes.outputs.create }}
      UPDATE_COUNT: ${{ steps.plan-changes.outputs.update }}
      DELETE_COUNT: ${{ steps.plan-changes.outputs.delete }}
      TOTAL_COUNT:  ${{ steps.plan-changes.outputs.total }}
```

## Original idea
https://docs.gitlab.com/user/infrastructure/iac/mr_integration/
