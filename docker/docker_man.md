# Docker Image for Running Doxygen

The image is based on the archlinux image and contains doxygen and graphviz.
Additionally, it contains latex for possibly generating PDFs in the future.

The image is available on [ghcr](https://ghcr.io/agarwalsaurav/doxygen-arch:latest).

## Usage
Pull the image from `ghcr.io`:
```bash
docker pull ghcr.io/agarwalsaurav/doxygen-arch:latest
```

To run the image:
```bash
docker run --rm -v <local_dir>:<container_dir> ghcr.io/agarwalsaurav/doxygen-arch:latest --workdir <container_dir> <working-directory> <doxyfile-path> <html-output-dir>
```

For example:
```bash
docker run --rm -v $(pwd):/work ghcr.io/agarwalsaurav/doxygen-arch:latest --workdir /work ./ doc/Doxyfile doc/html
```

Arguments | Description
--- | ---
`<local_dir>` | The local directory to be mounted in the container.
`<container_dir>` | The directory in the container where the local directory will be mounted.
`<working-directory>` | The working directory from where the doxygen command will be run.
`<doxyfile-path>` | The path to the Doxyfile relative to the working directory in the container.
`<html-output-dir>` | The directory relative to the working directory where the HTML documentation will be generated.


## License

This work is under an [MIT license](https://github.com/AgarwalSaurav/ghaction-doxygen-ghpages/blob/main/LICENSE).
