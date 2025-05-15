# GitHub Action for Doxygen and GitHub Pages {#mainpage}

GitHub Action for generating and deploying Doxygen documentation to a GitHub Pages branch.
The action uses a Docker container to run Doxygen; a reference Dockerfile is included in the repository.

As a test, this action is used to build the documentation of this repository itself.

## Basic Usage

To deploy documentation on every push to the `main` branch, create a workflow YAML file (e.g., `.github/workflows/doxygen.yml`):

```yml
on:
  push:
    branches:
      - main
permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Generate and Deploy Doxygen Docs
        uses: AgarwalSaurav/ghaction-doxygen-ghpages@release/v2
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          working-directory: .
          doxyfile-path: doc/Doxyfile
          html-output-folder: doc/html
          branch: gh-pages
          # env_list_file: path/to/env.list  # Uncomment and set if needed (see below)
```

> **Note:** Replace `main` with your default branch name as needed.

---

## Action Inputs

| Input                | Description                                                                                      | Default      |
| -------------------- | ------------------------------------------------------------------------------------------------ | ------------ |
| `github_token`       | The GitHub token used to push to the `gh-pages` branch.                                          | *(required)* |
| `working-directory`  | Directory from which Doxygen will be run.                                                        | `.`          |
| `doxyfile-path`      | Path to the Doxyfile (relative to the working directory).                                        | `./Doxyfile` |
| `html-output-folder` | Directory where HTML documentation will be generated (relative to working dir).                  | `doc/html`   |
| `branch`             | Branch to which documentation will be deployed.                                                  | `gh-pages`   |
| `target-folder`      | Directory in the deployment branch for documentation (relative path or `/`).                     | *(root)*     |
| `env_list_file`  | Path to a file containing environment variables to pass to the Docker container (see below).         | *(none)*     |

---

## Providing an `env_list_file`

If your Doxygen build requires custom environment variables (for example, for private credentials, proxies, or other build-time configuration), you can supply a file in [Docker --env-file format](https://docs.docker.com/reference/cli/docker/container/run/#env):

```
# Example: env.list
MY_VAR1=value1
MY_VAR2=value2
```

Add the file to your repository (or generate it securely at runtime) and provide its path as an input:

```yml
      - name: Generate and Deploy Doxygen Docs
        uses: AgarwalSaurav/ghaction-doxygen-ghpages@release/v2
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          # ...
          env_list_file: .github/workflows/env.list
```

If you do **not** require additional environment variables, you can omit this input.
The action will only pass the `--env-file` argument to Docker if the input is set and non-empty.

> **Security warning:** Never commit sensitive secrets in plaintext to your repository.
> Use [GitHub Actions secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) for sensitive data. This `env_list_file` is a convenience mechanism for non-secret, build-time configuration.

---

## Docker Image for Running Doxygen

The Docker image is based on the Arch Linux base image and includes Doxygen, Graphviz, and LaTeX (for future PDF generation).
It is available at:
`ghcr.io/agarwalsaurav/doxygen-arch:latest`

See the [`docker/`](docker/) directory and its [documentation](docker/docker_man.md) for further details.

---

## License

This project is released under the [MIT license](https://github.com/AgarwalSaurav/ghaction-doxygen-ghpages/blob/main/LICENSE).

It uses [JamesIves/github-pages-deploy-action](https://github.com/JamesIves/github-pages-deploy-action) for deployment to GitHub Pages.

**References:**

* [https://github.com/DenverCoder1/doxygen-github-pages-action](https://github.com/DenverCoder1/doxygen-github-pages-action)
* [https://github.com/mattnotmitt/doxygen-action](https://github.com/mattnotmitt/doxygen-action)
