# Aevum Terraform State and Validation

Status: Private Beta platform baseline

Aevum Terraform modules use a partial `gcs` backend. Backend bucket and prefix are supplied during initialization so production state is never committed to source control or silently stored on a developer workstation.

## Bootstrap the state bucket

Create the Terraform state bucket outside the workload modules or in a dedicated bootstrap stack. The state bucket should have:

- uniform bucket-level access;
- public access prevention enforced;
- object versioning enabled;
- no public CORS configuration;
- restricted IAM for platform/deployment identities only;
- retention/lifecycle appropriate for state recovery and organizational policy;
- logging/monitoring consistent with the production landing-zone policy.

Do not reuse the media archive, Firebase Storage, gallery, or function build-source bucket for Terraform state.

## Initialize by environment

Use a unique prefix for each module/environment. Example:

```bash
terraform -chdir=infrastructure/data/terraform init \
  -backend-config="bucket=YOUR_TERRAFORM_STATE_BUCKET" \
  -backend-config="prefix=aevum/prod/data"

terraform -chdir=infrastructure/computeless/terraform init \
  -backend-config="bucket=YOUR_TERRAFORM_STATE_BUCKET" \
  -backend-config="prefix=aevum/prod/computeless"
```

Use different prefixes and preferably separate projects/state boundaries for production and non-production environments.

## Local workflow

Before a pull request:

```bash
terraform fmt -recursive infrastructure
terraform -chdir=infrastructure/data/terraform init -backend=false
terraform -chdir=infrastructure/data/terraform validate
terraform -chdir=infrastructure/computeless/terraform init -backend=false
terraform -chdir=infrastructure/computeless/terraform validate
```

Static validation does not require access to production state.

## Plan/apply workflow

Production plan/apply should run from an authenticated deployment identity, not a personal credential. Preferred order:

1. initialize the correct remote backend;
2. select/verify the intended project/environment;
3. `terraform plan -out=...`;
4. review plan output and destructive/replacement actions;
5. require an approved change/PR and environment protection before apply;
6. apply the reviewed plan artifact;
7. retain deployment metadata and audit logs.

Never copy `.tfstate` or `.tfstate.backup` into the repository.

## Provider/version policy

- Terraform CLI: `>= 1.6.0, < 2.0.0`; CI currently pins stable Terraform 1.16.0.
- Google provider: compatible with the reviewed `7.45.x` line via `~> 7.45`.
- Archive provider: `2.8.0`.
- Each root module commits `.terraform.lock.hcl`; CI initializes with `-lockfile=readonly` so unreviewed provider resolution fails.
- Renovate/Dependabot-style updates should be reviewed through normal plans rather than auto-applied.

## Observed provider resolution

The committed locks resolve Google provider 7.46.0 within the approved `~> 7.45` constraint and Archive provider 2.8.0 at its exact constraint. PR Validation initializes both roots with the backend disabled, enforces the committed locks, and runs `terraform validate`. Provider updates must arrive as reviewable dependency pull requests and pass this gate.
