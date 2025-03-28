## Bicep Lint 

A lint is a great way to make sure that your code is without error and good formatting.   I used this [blog post] (https://johnnyreilly.com/bicep-lint-azure-pipelines-github-actions).  In the end, I put the lint for bicep in the deploy.yml file and seeing it run and checking the code was nice. It helped me learn to troubleshoot the problems with the YAML and BICEP code.  

Here is the code:

```yaml 

jobs:
lint:
  name: Lint Bicep Templates
  runs-on: ubuntu-latest steps:
- name: Checkout Repository
uses: actions/checkout@v3 with:
path: minecraft-azure-server

- name: Run Bicep Linter
uses: synergy-au/bicep-lint-action@v1
with: analyse-all-files: "true"
target-directory: minecraft-azure-server/infrastructure
 ```
