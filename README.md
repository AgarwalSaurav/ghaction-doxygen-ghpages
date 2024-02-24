\mainpage

GitHub Action for generating and deploying Doxygen documentation to a GitHub pages branch.
The action uses a docker container to run doxygen; the Dockerfile is also included in the repository.

As a test, the action is used to create the documentation of the repository itself.

## Basic Usage

To deploy docs on every push to the `main` branch, create a new file in the `.github/workflows/` directory with the workflow name, for example, `doxygen.yml`:

```yml
on:
  push:
    branches:
      - arch
permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Action Doxygen and GitHub Pages
        id: ghaction
        uses: ./
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          working-directory: .
          doxyfile-path: doc/Doxyfile
          html-output-folder: doc/html
          branch: gh-pages
          target-folder: /
```

## Action Inputs

|Input | Description | Default|
|--- | --- | ---|
|`github_token` | The GitHub token used to push to the `gh-pages` branch. | |
|`working-directory` | The working directory from where the doxygen command will be run. | `.` |
|`doxyfile-path` | The path to the Doxyfile relative to the working directory. | `./Doxyfile` |
|`html-output-folder` | The directory where the HTML documentation will be generated. | `doc/html` |
|`branch` | The branch where the documentation will be deployed. | `gh-pages` |
|`target-folder` | The directory in the `branch` where the documentation will be deployed. | `/` |

## Docker image for running Doxygen
The docker image is based on the archlinux image and contains doxygen and graphviz.
Additionally, it contains latex for possibly generating PDFs in the future.
It is located at [Docker Hub](https://ghcr.io/agarwalsaurav/doxygen-arch:latest).

See the `docker` directory and its [documentation](manual_docker) for more details.

## License

This work is under an [MIT license](https://github.com/AgarwalSaurav/ghaction-doxygen-ghpages/blob/main/LICENSE).

The [JamesIves/github-pages-deploy-action](https://github.com/JamesIves/github-pages-deploy-action) action is used to deploy the documentation to GitHub Pages.

Based on:
- https://github.com/DenverCoder1/doxygen-github-pages-action
- https://github.com/mattnotmitt/doxygen-action
