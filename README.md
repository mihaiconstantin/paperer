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

`paperer` is a lightweight executable to quickly scaffold a *mostly* `APA` style
manuscript in `LaTeX`. The idea is to install it once and run it anytime you
want to start writing a new manuscript. `paperer` will provide simpler project
structure and set of files, just enough to quickly get you started writing.
Currently, `paperer` is build only for `macOS` and other `Unix`-based operating
systems. Support for `Windows` may be added based on user demand.

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

The help message will look like this:

```txt
Usage: paperer [option]

Options:
   -d, --directory=DIR    The directory DIR where to scaffold the paper
   --update               Update 'paperer' from GitHub
   --uninstall            Uninstall 'paperer'
   --help                 Display this help message

Description:
   - Repository: https://github.com/mihaiconstantin/paperer
   - Mihai Constantin (mihai@mihaiconstantin.com)
```

Then, to scaffold a new paper, simply run:

```bash
paperer --directory=/path/to/manuscript
```

This option will create a new directory at `/path/to/manuscript` and scaffold the
`LaTeX` files inside it. The directory will have the following structure:

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

Check out the `sample/` directory for a `.pdf` [sample document]().

## Release Notes

See the [CHANGELOG](CHANGELOG.md) file.

## Contributing

Any contributions, suggestions, or bug reports are welcome and greatly
appreciated.

## License

`paperer` is licensed under the [MIT license](LICENSE).
