# Project Management

This page provides a full guide on how to manage a serious-scaffold-generated project on the open-source platform.

## Prerequisites

[`copier`](https://copier.readthedocs.io/) serves as a key tool in `serious-scaffold`, differentiating it from other project templates. The installation can be done with the following command.

```{note}
Using `pipx` for management is recommended and you can find pipx's installation instructions [here](https://pypa.github.io/pipx/installation/).
```

```bash
# Copier: Template rendering for projects.
pipx install copier
```

## Project Creation


```{include} ../../README.md
:start-line: 23
:end-line: 45
```

## Project Configuration

There are several configurations to utilize the features provided by the project template. These are only the essential ones, you can adjust according to your project's actual needs.

### Protection

Normally, a project on the open-source platform is public and anyone can access it. However, it is recommended to protect the project by some rules, such as:

- Branch Protection: Require pull requests to be reviewed and approved before merging.
- Tag Protection: Protect the release tags from being modified or deleted.

### Merge Strategy

Merge Strategy is a critical aspect of project management. It determines how changes from different branches are merged into the default branch.

- Rebase and Squash Commits: Prefer to use the `Rebase and Squash`. This ensures that the commit history is clean and easy to understand.
- Check Status Before Merging: Ensure that all changes are tested and passing before merging.

### Pages

GitHub/GitLab Pages is a convenient way to host static websites for your project. It can be used to host the documentation, demo, or any other static content.

- GitHub Pages: To enable GitHub Pages, you need to navigate to the repository settings and enable the Pages feature and set the source branch to `gh-pages`.

### Codecov

Codecov is a popular tool for measuring code coverage. It can be integrated with GitHub/GitLab to provide a visual representation of the code coverage of the project. The project need a Codecov token `CODECOV_TOKEN` to enable the integration.

- [GitHub Codecov](https://docs.codecov.com/docs/github-tutorial)
- [GitLab Codecov](https://docs.codecov.com/docs/gitlab-tutorial)

```{note}
It is enabled by default. And you can disable the Codecov integration by passing the flag `-d/--data use_codecov=false` to copier.
```

### Release

Release is also a critical aspect of project management. It is important to follow a standardized release process to ensure that the project is well-maintained and up-to-date. We apply the [semantic-release](https://github.com/semantic-release/semantic-release) to automate the release process. At least, a permitted token is required to enable the published release can trigger the released CD pipeline.

See the [release workflow](../topics/release_workflow.md) for more details on how to manage releases painlessly.

### Renovate

[Renovate](https://docs.renovatebot.com/) is a popular tool for automating dependency updates. It can be integrated with GitHub/GitLab to automatically create pull requests to update the dependencies. The project need a Renovate token `RENOVATE_TOKEN` to enable the integration. It is disabled by default, see the [Automating Dependency Updates](../topics/automate_dependencies.md) topic to learn how to enable it.

## Project Update

Thanks to the update mechanism provided natively by `copier`, when a new version of the template is released, you can easily update the project. Just run the following command under the root directory:

```bash
copier update
```

```{note}
The `-A/--skip-answered` flag can be used to skip questions that have already been answered.
```

In most cases, `copier` will manage updates seamlessly. If conflicts arise, they can be resolved manually since everything is version-controlled by Git.

```{tip}
To minimize potential conflicts, there are several suggestions to follow:
1. Avoid modifying the auto-generated files unless absolutely necessary.
1. For template-related changes, consider proposing an issue or change request directly to the template repository.
1. For project-specific changes, adopt an inheritance or extension approach to minimize the changes to auto-generated contents.
```

For more details, please refer to `copier update --help` and [the copier official documentation](https://copier.readthedocs.io/en/stable/updating/).
