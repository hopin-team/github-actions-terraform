# github-actions-tflint

Runs `tflint` and comments on a PR with reviewdog.

## Usage

If your repository does not have a `CR_PAT` token set, request it using INFR project in JIRA.

```
name: Code Review

on: [pull_request]

jobs:

  tflint:
    name: tflint

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

      - name: modified files
        id: modified-files
        uses: lots0logs/gh-action-get-changed-files@2.1.4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}

      - name: tflint
        uses: hopin-team/github-actions-terraform/tflint@main
        with:
          files: '${{ steps.modified-files.outputs.modified }}'
```
