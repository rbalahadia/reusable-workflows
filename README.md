# reusable-workflows
Github action reusable workflows

## autoPullRequest.yaml
🧩 Reusable Workflow: example-repo/.github/workflows/your-workflow.yml
- This workflow automatically creates a pull request based on your trigger. 
📥 Inputs
| Name                | Description                                                       | Required | Type     | Default         |
| ------------------- | ----------------------------------------------------------------- | -------- | -------- | --------------- |
| `SOURCE_BRANCH`     | The source branch for the pull request or merge.                  | ✅ Yes    | `string` | —               |
| `TARGET_BRANCH`     | The target branch where changes will be merged.                   | ✅ Yes    | `string` | —               |
| `REPOSITORY_TARGET` | The name of the target repository (e.g. `org/repo`).              | ✅ Yes    | `string` | —               |
| `REVIEWERS`         | Comma-separated list of GitHub usernames to request as reviewers. | ❌ No     | `string` | `"user1,user2"` |
🔐 Secrets
| Name           | Description                                                          | Required |
| -------------- | -------------------------------------------------------------------- | -------- |
| `RUNNER_TOKEN` | Token used for authenticating the workflow run or repository access. | ✅ Yes    |
🧰 Example Usage
<pre><code class="yaml">
jobs:
  create-pr:
    uses: rbalahadia/reusable-workflows/.github/workflows/autoPullRequest.yaml@main
    with:
      SOURCE_BRANCH: feature/new-ui
      TARGET_BRANCH: develop
      REPOSITORY_TARGET: org/frontend-repo
      REVIEWERS: alice,bob
    secrets:
      RUNNER_TOKEN: ${{ secrets.RUNNER_TOKEN }}
</code></pre>

## ecsDeployScript.yaml
🧩 Reusable Workflow: ecsDeployScript.yaml
- This workflow is for deploying changes to ECS Fargate.<br>
📥 Inputs<br>
| Name                | Description                                                                   | Required | Type     | Default       |
| ------------------- | ----------------------------------------------------------------------------- | -------- | -------- | ------------- |
| `AWS_REGION`        | AWS region where the deployment will run.                                     | ❌ No     | `string` | `"ap-southeast-1"` |
| `ENVIRONMENT_STAGE` | The environment stage (e.g. `dev`, `staging`, `prod`).                        | ✅ Yes    | `string` | —             |
| `ENVIRONMENT_URL`   | The base URL of the environment.                                              | ✅ Yes    | `string` | —             |
| `GENERAL_NAME`      | A general identifier or service name used for tagging and grouping resources. | ✅ Yes    | `string` | —             |
| `ECS_NAME_CODE`     | The ECS service or task definition code name.                                 | ✅ Yes    | `string` | —             |
| `SRV_COUNT`         | Desired number of ECS service instances.                                      | ✅ Yes    | `string` | `"1"`         |

🔐 Secrets<br>
| Name          | Description                                        | Required |
| ------------- | -------------------------------------------------- | -------- |
| `ASSUME_ROLE` | IAM role ARN to assume for deployment permissions. | ✅ Yes    |
🧰 Example Usage<br>
<pre><code class="yaml">
jobs:
  deploy:
    uses: rbalahadia/reusable-workflows/.github/workflows/ecsDeployScript.yaml@main
    with:
      ENVIRONMENT_STAGE: prod
      ENVIRONMENT_URL: https://example.com
      GENERAL_NAME: core-service
      ECS_NAME_CODE: core-api
      SRV_COUNT: "2"
    secrets:
      ASSUME_ROLE: ${{ secrets.ASSUME_ROLE }}
</code></pre>

## ssmDeployScript.yaml
🧩 Reusable Workflow: ssmDeployScript.yml<br>
- This workflow is for deploying to EC2 instances that have SSM agent installed.<br>
📥 Inputs<br>
| Name                | Description                                                   | Required | Type     | Default |
| ------------------- | ------------------------------------------------------------- | -------- | -------- | ------- |
| `BUCKET_NAME`       | Target S3 bucket name to deploy files to.                     | ✅ Yes    | `string` | —       |
| `AWS_REGION`        | AWS region where the bucket is hosted.                        | ✅ Yes    | `string` | —       |
| `ENVIRONMENT_STAGE` | Environment stage identifier (e.g. `dev`, `staging`, `prod`). | ✅ Yes    | `string` | —       |
| `ENVIRONMENT_URL`   | Base URL of the deployed environment.                         | ✅ Yes    | `string` | —       |
| `TAG_KEY`           | Resource tag key to apply to deployed assets.                 | ✅ Yes    | `string` | —       |
| `TAG_VALUE`         | Resource tag value to apply to deployed assets.               | ✅ Yes    | `string` | —       |
| `DEPLOY_SCRIPT`     | Deployment script or command to execute.                      | ✅ Yes    | `string` | —       |
| `DEPLOY_COMMENT`    | Optional comment or description for this deployment.          | ❌ No     | `string` | —       |

🔐 Secrets<br>
| Name          | Description                                      | Required |
| ------------- | ------------------------------------------------ | -------- |
| `ASSUME_ROLE` | IAM role ARN assumed for deployment permissions. | ✅ Yes    |


🧰 Example Usage<br>
<pre><code class="yaml">
jobs:
  deploy:
    uses: rbalahadia/reusable-workflows/.github/workflows/ssmDeployScript.yaml@main
    with:
      BUCKET_NAME: my-app-bucket
      AWS_REGION: eu-west-1
      ENVIRONMENT_STAGE: prod
      ENVIRONMENT_URL: https://myapp.example.com
      TAG_KEY: project
      TAG_VALUE: core-service
      DEPLOY_SCRIPT: scripts/deploy.sh
      DEPLOY_COMMENT: "Production deployment"
    secrets:
      ASSUME_ROLE: ${{ secrets.ASSUME_ROLE }}
</code></pre>