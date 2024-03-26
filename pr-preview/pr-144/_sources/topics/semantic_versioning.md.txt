# Semantic Versioning

This document describes the semantic versioning scheme used in the project.

## Why use semantic versioning?

[Dependency hell](https://en.wikipedia.org/wiki/Dependency_hell) is a common problem needing to be addressed in modern software development. Semantic versioning is a simple and well-defined versioning scheme that provides a clear and consistent way to communicate software versions. Through the use of semantic versioning, one can gain insights into the impact of code changes across different versions and confidently manage dependencies. For more information on semantic versioning, please visit [semver.org](https://semver.org/).

## Versioning scheme

The versioning scheme used in the project is `MAJOR.MINOR.PATCH`. It contains the common rules for incrementing the version number:

- `MAJOR` version when you make incompatible API changes,
- `MINOR` version when you add functionality in a backwards-compatible manner, and
- `PATCH` version when you make backwards-compatible bug fixes.

And more about pre-release and build metadata can be found in the [semver.org](https://semver.org/).


## How to use semantic versioning in the project

Happily, the automatic [release workflow](release_workflow.md) in the project will automatically generate a new release with a new semantic version number based on the changes in the code. So, all we need to do is to follow the [Commit conventions](../tutorials/commit_convention.md) and make sure that the changes are backward-compatible.
