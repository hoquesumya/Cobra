# Contributing

This CONTRIBUTING.md is intended for developers interested in improving the Cobra compiler, standard library, or associated tools. It includes guidelines for contributions and a reference manual to help you understand Cobra’s language design and features. Your expertise and contributions are vital to Cobra's development and evolution.

# Submitting Changes

To maintain a clean and navigable git history in the Cobra project, we adhere to strict standards regarding pull requests (PRs) and commit practices. By following these guidelines, you help ensure that the project's development process is streamlined and that the git tree remains clean and understandable.

## Pull Requests (PRs)
- **Branching**: Always create a feature branch from the latest version of the main branch for each new piece of work. This isolates development efforts and makes it easier to manage merges and reviews.
- **Isolation of Changes**: Each pull request should represent a single logical change. Do not combine multiple unrelated changes into one PR. This simplification helps reviewers understand and evaluate your changes more effectively.
Descriptive Titles: PR titles should succinctly convey the essence of the change. This aids in quick identification and helps when generating release notes.
- **Detailed Descriptions**: Include a comprehensive description with each PR. Explain the rationale behind the change, what it accomplishes, and any other relevant details. If the PR fixes a bug, include a clear description of the problem and the fix.
- **Review and Merge**: PRs require at least one peer review before merging. Ensure that merges into the main branch are done using the "Squash and Merge" strategy to keep the history clean.

## Commits

Adhering to a semantic commit practice is crucial for generating clear and helpful logs. Here are the standards for making commits in Cobra:

### Message Structure

Each commit message should consist of three parts: a type, a scope, and a subject:

```
<type>(<scope>): <subject>
```
- **Type**: This describes the nature of the changes and can include types like feat (new feature), fix (bug fix), docs (documentation), style (formatting, missing semicolons, etc.), refactor (code change that neither fixes a bug nor adds a feature), and test (adding missing tests).
- **Scope**: A quick context where the change is occurring, e.g., parser, runtime, stdlib, etc.
- **Subject**: A brief summary of the changes, written in the imperative mood ("add", not "adds" or "added").

### Atomic Commits

Make small, atomic commits that each handle one specific task. This practice makes it easier to pinpoint bugs with tools like git bisect and simplifies potential rollbacks.

### Test Before Committing

Before committing, ensure your changes do not break existing functionality by running all the tests. If your changes include new features or fixes, write and commit new tests simultaneously.

## Language Reference

For more complete instructions on the language reference, see the [LRM](./LRM.md).
