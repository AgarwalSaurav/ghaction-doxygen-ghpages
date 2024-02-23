# Doxygen and Github Pages

GitHub Action for making and deploying Doxygen documentation to a GitHub pages branch

## Basic Usage

To deploy docs on every push to the `main` branch, create a new file in the `.github/workflows/` directory called `doxygen-gh-pages.yml` with the following contents:

```yml
name: Doxygen and GitHub Pages

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: AgarwalSaurav/ghaction-doxygen-ghpages@v1.0.0
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Options

- `github_token` (required): GitHub token for pushing to repo. See the [docs](https://git.io/passing-token) for more info.
- `branch` (optional): Branch to deploy to. Defaults to `gh-pages`.
- `folder` (optional): Folder where the docs are built. Defaults to `docs/html`.
- `config_file` (optional): Path of the Doxygen configuration file. Defaults to `Doxyfile`.
- `target_folder` (optional): Directory within the deployment branch to push to. Defaults to empty (root).

## Advanced Usage

Here is an example of a `.github/workflows/doxygen-gh-pages.yml` file with more advanced configuration:

```yml
name: Doxygen and GitHub Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: AgarwalSaurav/ghaction-doxygen-ghpages@v1.0.0
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          branch: gh-pages
          folder: docs/html
          config_file: Doxyfile
```

## License

This work is under an [MIT license](LICENSE)

The [JamesIves/github-pages-deploy-action](https://github.com/JamesIves/github-pages-deploy-action) action is used to deploy the documentation to GitHub Pages.

Based on: https://github.com/DenverCoder1/doxygen-github-pages-action

- Update Doxygen version to 1.10.0
- Update actions/checkout to v4
- Update JamesIves/github-pages-deploy-action to v4.5.0
