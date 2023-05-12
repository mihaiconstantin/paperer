# Changelog

## [1.0.1] - 2023-05-12

### Fixed
- Add missing `folders` array to `manuscript.code-workspace` file for the `apa`
  template.
- Remove redundant check for ownership change in `paperer.sh` script.

## [1.0.0] - 2023-05-12

### Added
- Add sample document `apa-sample.pdf` for default `apa` template.
- Add `paperer` script with the following options:
  - `--source` or `-s` to specify the source directory where the templates are
    located
  - `--template` or `-t` to specify which template to use
  - `--directory` or `-d` to specify the directory where to scaffold to scaffold
    a new `LaTeX` manuscript
  - `--update` to update `paperer` from GitHub
  - `--uninstall` to uninstall `paperer`
  - `--help` to display the help message
- Add `install.sh` script to install `paperer`.
- Generate a reasonable logo via `DALL-E`.
- Add documentation to `README.md`.
- Add `LaTeX` project template based on the `apa7` class.
