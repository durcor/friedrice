# Global Pi workflow instructions

## Credentials

If you experience AWS session expiry, consult ~/.aws/config to determine the profile config and authentication flow.

## Git workflow

Always add changes in a separate bash tool call than committing and pushing.
This allows me to view the diff before approving the commit and pushing it.

## Post-push CI workflow

A successful `git push` is not task completion when the task requires CI or pipeline validation.

After pushing code:

1. Identify the CI run or pipeline associated with the pushed commit.
2. Wait for its terminal result, polling if it has not appeared yet.
3. If it fails, inspect the failed logs, fix the issue, push the fix, and repeat this workflow.
4. Do not claim the task is complete until every required CI run has passed.
5. Explicitly report the final pipeline result and any remaining external or manual checks.

If the CI provider cannot be queried, say so plainly and do not represent the change as fully validated.
