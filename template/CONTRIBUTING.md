# Contributing

Our scaffolds are community-driven and open-source, anddesigned to save time and effort, allowing developers to focus on writing code that matters most. Your contributions are invaluable!

## Environment setup

Fork and clone the repository.

### Light Environment

If you don't want to run the full test suite, you can just create a virtual environment based on python and install copier and pre-commit:

```bash
Optional virtualenv, depends on your develop environment
pipx install virtualenv pre-commit
virtualenv .venv
source .venv/bin/activate

pip install copier
```

### Devcontainer Environment

If you want to run the full testable environment, you can use the devcontainer provided in the folder `.devcontainer`.

To use the devcontainer, refer to [Dev Containers tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial).

## Development

As usual:

- create a new branch: `git switch -c feature-or-bugfix-name`.
- edit the code and/or the documentation.
- run `copier copy --vcs-ref=HEAD -l . .` to generate the current repository.
- run `pre-commit run -a` to check if any errors can be fixed.
- if everything is fine, your changes are ready to commit and follow our convention based on the Commit Convention.
- push your branch to your fork and create a pull request.

## Pull Requests Guidelines

Link to any related issue in the Pull Request message.

During the review, we recommend using fixups:

```bash
# SHA is the SHA of the commit you want to fix
git commit --fixup=SHA
```

Once all the changes are approved, you can squash your commits:

```bash
git rebase -i --autosquash master
```

And force-push:

```bash
git push -f
```

If this seems all too complicated, you can push or force-push each new commit,
and we will squash them ourselves if needed, before merging.
