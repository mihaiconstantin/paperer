<p align="center">
    <a href="https://github.com/mihaiconstantin/paperer">
        <img width="180px" src="assets/logo-paperer.png" alt="paperer logo"/>
    </a>
</p>

<h1 align="center">
    Start Writing That Paper
    <br>
    <sub>...in seconds</sub>
</h1>

<!-- badges: start -->
<p align="center">
    <a href="https://www.repostatus.org/#active"><img src="https://www.repostatus.org/badges/latest/active.svg" alt="Repository status"/></a>
    <a href="https://github.com/mihaiconstantin/paperer/releases"><img src="https://img.shields.io/github/v/release/mihaiconstantin/paperer?display_name=tag&sort=semver" alt="GitHub version"/></a>
    <a href="https://github.com/mihaiconstantin/paperer/issues"><img src="https://img.shields.io/github/issues/mihaiconstantin/paperer" alt="GitHub issues"></a>
</p>
<!-- badges: end -->

`paperer` is a lightweight executable to quickly scaffold `LaTeX` projects.
Starting a new manuscript can be a tedious process, and often requires copying
files from previous projects, or searching for templates online. `paperer` aims
to simplify this process by providing a simple executable that can be used to
scaffold a new version-controlled manuscript in `LaTeX` based on a given
template. A template is simply a collection of files that make up a manuscript.
Currently, `paperer` provides a *mainly* `APA` template, but more templates are
welcomed as contributions (i.e., see the [Contributing](#contributing) section).
Alternatively, you can use your own templates by specifying the source directory
where to look for the template files (i.e., see the [Usage](#usage) section). In
a nutshell, the idea behind `paperer` is to install it once and run it anytime
you want to start writing a new manuscript.

`paperer` is build for `macOS` and other `Unix`-based operating systems.
However, support for `Windows` may be added based on user demand.

## Installation

### Prerequisites

While you can install `paperer` and scaffold a manuscript without any
prerequisites, you will need a `LaTeX` distribution installed on your system to
compile the manuscript. Please check
[tug.org/texlive](https://www.tug.org/texlive/) for more information on how to
install `LaTeX` on your system.

### Installing

To install `paperer`, simply run the following command:

```bash
curl https://raw.githubusercontent.com/mihaiconstantin/paperer/main/install.sh | sudo bash
```

The command above will perform the following steps:

1. Clone the `mihaiconstantin/paperer` repository to `/usr/local/paperer`.
2. Adjust permissions and create `paperer` executable from `/usr/local/paperer/paperer.sh`
3. Create symbolic link in `/usr/local/bin` for `paperer -> /usr/local/paperer`.

### Uninstalling

To uninstall `paperer` simply run:

```bash
paperer --uninstall
```

The `--uninstall` flag will reverse the installation steps described above.

### Updating

To update `paperer` you can run:

```bash
paperer --update
```

This `--update` flag will pull the latest changes from GitHub into your local
copy of the repository available at `/usr/local/paperer`.

## Usage

You can start by print the help message using the `--help` or `-h` options:

```bash
paperer --help
```

The help message will look as follows:

```txt
Usage: paperer [option]

Options:
   -d, --directory=DIR    The directory DIR where to prepare the paper without the trailing slash.
   -t, --template=TPL     The template TPL to use for scaffolding. The default is 'apa'.
                          Currently included templates with 'paperer' are: 'apa'.
                          However, custom templates can be used by specifying the source folder.
   -s, --source=DIR       Source directory where to look for the template TPL for scaffolding.
                          The default is the 'templates' folder of the 'paperer' installation.
                          This option is useful if you want to use your own templates.
   --update               Update 'paperer' from GitHub.
   --uninstall            Uninstall 'paperer'.
   --help                 Display this help message.

Description:
   - Repository: https://github.com/mihaiconstantin/paperer
   - Mihai Constantin (mihai@mihaiconstantin.com)
```

Then, to prepare a new manuscript at path `/path/to/manuscript`, simply run:

```bash
paperer --directory=/path/to/manuscript
```

This option will create a new directory at `/path/to/manuscript` and scaffold
the `LaTeX` files associated with the default `apa` template. The scaffolding
process for the `apa` template will result in the following structure:

```txt
manuscript
├── README.md
├── archive
├── build
├── graphics
├── library.bib
├── manuscript.code-workspace
├── manuscript.tex
└── sections
    ├── _footnotes.tex
    ├── _outline.tex
    ├── _sections.tex
    ├── abstract.tex
    ├── introduction.tex
    └── section-one.tex
```

Check out the document [`apa-sample.pdf`](./samples/apa-sample.pdf) in
`samples/` directory for an example of the resulting manuscript. Also, check out
the `--template` and `--source` flags to specify your own local templates.

## Release Notes

See the [CHANGELOG](CHANGELOG.md) file.

## Contributing

Any contributions, suggestions, or bug reports are welcome and greatly
appreciated. Please open an
[issue](https://github.com/mihaiconstantin/paperer/issues) or submit a [pull
request](https://github.com/mihaiconstantin/paperer/pulls).

One way to contribute is to provide a new template for a different style of
manuscript. To do so, please open a [pull request]() as follows:

1. Create a new directory in the `templates/`.
2. Add a sample of the resulting document in the `samples/` directory, following
   the naming convention `<template-name>-sample.pdf`.
3. Adjust the the function `display_help` in `paperer.sh` to include the new
   template in the help message.

Another way to contribute is by helping with translating the `bash` scripts
`install.sh` and `paperer.sh` to other `PowerShell` or `Batch` scripts for
`Windows`.

## License

`paperer` is licensed under the [MIT license](LICENSE).
