# Release Workflow

This document describes the release workflow including the steps to configure, use and customize the semantic-release to automate the release process.

## Configuration

It requires the following variables to be set in the repository's CI environment to make the released/published events trigger cd jobs in the cd pipeline.

```{note}
For open-source repositories or organizations, it is recommended to use a bot account to avoid the risk of exposing the PAT.
```

### On GitHub

A token with the permission to **read and write access to code, commit statuses, issues, pull requests, and workflows** can be one of the following on GitHub:

- Apply for a token based on [GitHub App](https://docs.github.com/en/apps/creating-github-apps/about-creating-github-apps/about-creating-github-apps) needs to set the following variables.
  - BOT_APP_ID: acquired from the GitHub App in the actions' variables section.
  - BOT_APP_PRIVATE_KEY: acquired from the GitHub App in the actions' secrets section.
- Apply for a personal access token ([PAT](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)) needs to set the following variables.
  - PAT: acquired from a pernsonal account settings.

## Available Workflows

According to the semantic-release documentation, there are several workflows available for the release process:

- [Maintenance release](https://semantic-release.gitbook.io/semantic-release/recipes/release-workflow/maintenance-releases)
- [Pre-release](https://semantic-release.gitbook.io/semantic-release/recipes/release-workflow/pre-releases)
- [Distribution channels](https://semantic-release.gitbook.io/semantic-release/recipes/release-workflow/distribution-channels)


## Release Configurations

The semantic-release can be customized to fit the specific needs of the repository. The following are some of the common customizations we have used in the project according to the configuration file `.releaserc.js`:

```{literalinclude} ../../.releaserc.js
:language: javascript
```

References the section `@semantic-release/commit-analyzer`, we have the release trigger rules:

- `breaking`: `BREAKING CHANGE`, `BREAKING CHANGES`, ` BREAKING` in the commit message body can trigger a major release.
- `feat` in the commit message title can trigger a minor release.
- `fix`, `refactor`, `perf` and `revert` in the commit message title can trigger a minor release.
- `chore`, `build`, `ci`, `docs` and `test` in the commit message title skip a release.
- `*no-release*` in the commit message title scope can skip a release.

References the section `@semantic-release/release-notes-generator`, we have the release notes will be generated based on the commit messages.

- `BREAKING CHANGE`, `BREAKING CHANGES`, ` BREAKING` in the commit message body will be included in the release notes.
- `feat` as the section `Features`.
- `fix` as the section `Bug Fixes`.
- `refactor` as the section `Refactor`.
- `perf` as the section `Performance`.

And the reset follows the same rules in the configured file.

## No release with commits

By default, the semantic-release analyzes the commit messages to determine the type of release (major, minor, patch) if it should generate a new release or not. If the commit messages are not in the expected format, the release will be skipped.

Based on the above the mechanism, if the rebasing and merging prs are not qualified for a release, we can modify the rebase and merge commit message to  the scope `no-release`. For example, `fix(no-release): a fix that should not trigger a release` and `feat(no-release): a feature that should not trigger a release`. If it contains more details, it must be separated by a comma. The following commit message will not trigger a release:

- `fix(no-release): a fix that should not trigger a release`
- `fix(no-release,core): a fix that should not trigger a release, but it has more details`
- `feat(no-release): a feature that should not trigger a release`
- `feat(core,no-release): a feature that should not trigger a release, but it has more details`
