#!/bin/bash

# Replace with your GitHub org or username
OWNER="your-org-or-username"

# Get all repos under the owner
gh repo list $OWNER --limit 500 --json name,defaultBranchRef | \
jq -r '.[] | select(.defaultBranchRef.name == "main") | .name' | \
while read repo; do
    echo "Applying branch protection to: $repo"

    gh api -X PUT \
      -H "Accept: application/vnd.github+json" \
      "/repos/$OWNER/$repo/branches/main/protection" \
      -f required_status_checks='{"strict": true, "contexts": []}' \
      -f enforce_admins=true \
      -f required_pull_request_reviews='{"required_approving_review_count": 1, "require_code_owner_reviews": true}' \
      -f restrictions='null'
    gh api -X PATCH \
        -H "Accept: application/vnd.github+json" \
        "/repos/$OWNER/$repo/branches/main" \
        -f protection.allow_force_pushes=false \
        -f protection.allow_deletions=false
done
echo "Branch protection applied to all repositories."
# Note: This script assumes that you have the GitHub CLI (gh) and jq installed.
# It also assumes that you have authenticated with GitHub CLI and have the necessary permissions to modify branch protection rules.
# Make sure to replace "your-org-or-username" with your actual GitHub organization or username.
# This script applies branch protection rules to all repositories under the specified owner.
# It sets the default branch to "main" and applies the following rules:
# - Required status checks: strict mode with no contexts
# - Enforce admins: true
# - Required pull request reviews: 1 approving review
# - No restrictions on who can push to the branch
# You can modify the parameters as needed to fit your requirements.