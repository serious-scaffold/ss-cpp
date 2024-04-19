# Automate Dependencies

This page describes how we can be aware of and manage our dependencies and their updates using the tool renovate.

## Configuration

It requires a token `RENOVATE_TOKEN` with the appropriate permissions to make changes to the repository and trigger the CI/CD pipeline of that change.

```{note}
For open-source repositories or organizations, a bot account is recommended to avoid the risk of exposing the token and make team collaboration more manageable.
```

### On GitHub

It can simply reuse the existing configuration of the release workflow . See the [release workflow configuration](./release_workflow.md) section.

- Option 1: Apply the same bot configured variables and secrets:
  - BOT_APP_ID
  - BOT_PRIVATE_KEY
- Option 2: Apply the same PAT to set as the renovat token `RENOVATE_TOKEN`.

```{note}
Normally, the author of prs created by Renovate will be assigned automatically to the bot account if it is configured with Option 1 or the account of the PAT if it is configured with Option 2. But it may be customized to assign the author by `RENOVATE_GIT_AUTHOR` variable. And its format should be `username <useremail>`.
```

## Customize dependencies detection

Although we have configured the dependencise covering common dependencies we use in the project ,it can be customized to include more dependencies detection into the renovate configuration `renovaterc.json`, which is located in the root directory of the repository. See the [official documentation](https://docs.renovatebot.com/configuration-options/) for more information.
