# Commit Convention

This guides the contributors to follow a consistent commit message format. And it helpes maintain a clean and readable git history and streamline the release process for release automation tools like semantic-release we use in this project.

## For Release Automation

Because we need to support semantic-release to automate the [release workflow](../topics/release_workflow.md), and it supports parsing of many semantic commit formats such as [`angular`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-angular), [`atom`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-atom), [`codemirror`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-codemirror), [`ember`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-ember), [`eslint`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-eslint), [`express`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-express), [`jquery`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-jquery), [`jshint`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-jshint), [`conventionalcommits`](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-conventionalcommits).

We combine and customize the commit message format angular and conventionalcommits.

### Commit Message Format

The commit message format should be in the following format:

```tex
<type>(<scope>): <short summary>
  │       │             │
  │       │             └─⫸ Summary in present tense. Not capitalized. No period at the end.
  │       │
  │       └─⫸ Commit Scope: a specific component or part of the system affected by the change.
  │
  └─⫸ Commit Type: build|chore|ci|docs|feat|fix|perf|refactor|test

Commit Message Body

Commit Message Footer
```

### Commit Message Types

| Type      | Description                                            |
|-----------|--------------------------------------------------------|
| `build`   | Changes that affect the build system or dependencies.  |
| `chore`   | Routine tasks or changes outside the src/runtime code. |
| `ci`      | Changes related to continuous integration.             |
| `doc`     | Documentation changes.                                 |
| `feat`    | New features.                                          |
| `fix`     | Bug fixes.                                             |
| `perf`    | Performance improvements.                              |
| `refactor`| Code restructuring without changing behavior.          |
| `revert`  | Revert a previous commit.                              |
| `style`   | Code formatting changes.                               |
| `test`    | Add or update tests.                                   |

See the [release workflow](../topics/release_workflow.md) for more details how the configuration can be used to automate the release.

## For Semantic Versioning

Commit convention is also important for semantic versioning. It helps us to understand the impact of changes on the codebase and how to determine the next version number. With the help of semantic-release, we can automate the versioning process based on the commit messages.

See the [semantic versioning](../topics/semantic_versioning.md) for more details how the commit convention impacts codebase versioning.
