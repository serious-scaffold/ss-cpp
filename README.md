# Cpp Scaffold

A development-focused Cpp project template.

## Features

- Project setup and template update with [copier](https://github.com/copier-org/copier/).
- Customizable container development environment(vscode dev container).
- `Googletest` integration.
- `Vcpkg` integration.
- Standard dev source layout based on cmake and configuration cmake presets.
- Lint tool `pre-commit` integration.
- Sphinx integration as the sync docs tool.

## 🚀 Quickstart

1. Generate the project.

   ```bash
   copier copy gh:msclock/cpp-scaffold /path/to/project
   ```

2. Navigate to the project directory and initialize a git repository.

   ```bash
   cd /path/to/project
   git init
   ```

3. Commit the initialized project.

   ```bash
   git add .
   git commit -m "Init."
   ```

4. That's it! Feel free to focus on the coding within `src` folder.

## 📜 License

MIT License, for more details, see the [LICENSE](https://github.com/msclock/cpp-scaffold/blob/master/LICENSE) file.
