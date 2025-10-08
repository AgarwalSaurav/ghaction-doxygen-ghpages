# Docker Image for Running Doxygen

The image is based on the archlinux image and contains doxygen and graphviz.
Additionally, it contains latex for possibly generating PDFs in the future.

The image is available on [Docker Hub](https://hub.docker.com/r/agarwalsaurav/doxygen-arch).

## Usage
Pull the image from Docker Hub:
```bash
docker pull agarwalsaurav/doxygen-arch:latest
```

To run the image:
```bash
docker run --rm --workdir <container_dir> -v <local_dir>:<container_dir> agarwalsaurav/doxygen-arch:latest <working-directory> <doxyfile-path> <html-output-dir>
```

For example:
```bash
docker run --rm --workdir /work -v $(pwd):/work agarwalsaurav/doxygen-arch:latest . doc/Doxyfile doc/html
```

With environment variables:
```bash
docker run --rm --workdir /work -v $(pwd):/work --env-file env.list agarwalsaurav/doxygen-arch:latest . doc/Doxyfile doc/html
```

Arguments | Description
--- | ---
`<local_dir>` | The local directory to be mounted in the container.
`<container_dir>` | The directory in the container where the local directory will be mounted.
`<working-directory>` | The working directory from where the doxygen command will be run.
`<doxyfile-path>` | The path to the Doxyfile relative to the working directory in the container.
`<html-output-dir>` | The directory relative to the working directory where the HTML documentation will be generated.


## License

This project is released under the [MIT license](https://github.com/AgarwalSaurav/ghaction-doxygen-ghpages/blob/main/LICENSE).
