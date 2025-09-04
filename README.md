# Dockerized ORCA Environment

A containerized environment for running quantum chemistry calculations using ORCA. This project provides a Docker setup to create a reproducible and isolated environment for ORCA.

## Prerequisites

- Docker
- Git

## Features

- ORCA 6.0.1
- Python 3
- A non-root user for better security

> [!WARNING]
> **Create the `TOOLS` directory**
> 
> Before building the Docker image, you **must** create a directory named `TOOLS` in the root of the project. Inside this directory, you need to place the following required executable files:
> 
> - `orca`
> - `vina`
> 
> The build process will fail if these files are not present in the `TOOLS` directory.

## Quick Start

1.  Clone the repository:
    ```bash
    git clone <your-repository-url>
    cd Cheminformatics
    ```

2.  Build the Docker image:
    ```bash
    docker build \
      --build-arg USER_UID=$(id -u) \
      --build-arg USER_GID=$(id -g) \
      --build-arg USERNAME=$(whoami) \
      -t drug-design-env .
    ```

3.  Run the container:
    ```bash
    docker run -it --rm -v ${PWD}:/home/$(whoami)/app drug-design-env
    ```

4.  Inside the container, you can verify the ORCA installation:
    ```bash
    orca --version
    ```
    And the Vina installation:
    ```bash
    vina --version
    ```

## Directory Structure

```
.
├── dockerfile         # Docker configuration file
├── src/               # Source files for your project
│   └── main.py
├── TOOLS/             # Tools and installers
│   ├── orca
│   └── vina
└── README.md          # README file
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have questions, please open an issue in the GitHub repository.# ChemInformatics
