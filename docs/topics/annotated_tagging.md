# Annotated Tagging

For maintaining the codebase, it is essential to create a consistent and meaningful tagging system. This will help in identifying the purpose of each commit, the impact of changes, and the progress of the project. Here we will use annotated tagging to achieve this.

## What is Annotated Tagging?

Unlike lightweight tags, which are simply references to a specific commit, [annotated tags](https://git-scm.com/docs/git-tag) contain additional information about the commit.


## How to Create an Annotated Tag?

Happily, the process of creating an annotated tag has been configured with the semantic-release plugin `semantic-release/exec` in the file `.releaserc.js`, mentioned in the project [release workflow](release_workflow.md). What we developers need to do is to commit the code changes with the messages conforming to the commit convention. Once the changes are committed, a release triggered by the release workflow will create an annotated tag with the release version and the corresponding release notes attached to it.
