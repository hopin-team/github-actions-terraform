# github-actions-terraform-fmt

Runs `terraform fmt` and comments on a PR with reviewdog.

## Usage

If your repository does not have a `CR_PAT` token set, request it using INFR project in JIRA.

```
name: Code Review

on: [pull_request]

jobs:

  terraform-fmt:
    name: terraform fmt

    runs-on: ubuntu-latest

    container:
      image: ghcr.io/hopin-team/github-actions-terraform-runner:latest
      credentials:
        username: ${{ github.repository_owner }}
        password: ${{ secrets.CR_PAT }}

    env:
      REVIEWDOG_GITHUB_API_TOKEN: ${{ secrets.GITHUB_TOKEN }}

    steps:
      - name: checkout
        uses: actions/checkout@v2

      - name: terraform fmt
        uses: hopin-team/github-actions-terraform/terraform-fmt@main
```
