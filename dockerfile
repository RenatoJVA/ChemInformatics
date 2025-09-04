# 1. Usar una imagen base de Linux (Ubuntu es una buena opción)
FROM ubuntu:24.04

# Evitar prompts interactivos durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Copiar Vina al binario del sistema y hacerlo ejecutable
COPY ./TOOLS/vina /usr/bin/vina
RUN chmod +x /usr/bin/vina

# Argumentos para la creación de usuario
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=1000

# Crear grupo y usuario
RUN groupadd -g $USER_GID -o $USERNAME && \
    useradd -m -u $USER_UID -g $USER_GID -s /bin/bash $USERNAME

# 2. Instalar dependencias
RUN apt-get update && apt-get install -y --no-install-recommends \
    openmpi-bin \
    libopenmpi-dev \
    python3 \
    python3-pip \
    ca-certificates \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    vim \
    tree \
    btop \
    bzip2 \
    tmux \
    openjdk-17-jre \
    libfftw3-dev \
    mpich \
    gfortran \
    libopenblas-dev \
    liblapack-dev \
    libfftw3-bin \
    libxml2-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Cambiar al usuario no-root
USER $USERNAME

# 3. Crear un directorio de trabajo y copiar los archivos
WORKDIR /home/$USERNAME/app
COPY --chown=$USERNAME:$USERNAME ./TOOLS ./TOOLS/
COPY --chown=$USERNAME:$USERNAME ./src ./src/

# 4. Hacer que el instalador de ORCA sea ejecutable
RUN chmod +x ./TOOLS/orca_6_0_1_linux_x86-64_shared_openmpi416.run

# 5. Ejecutar el instalador de ORCA
# El instalador se ejecutará como el usuario no-root e instalará en su home
RUN ./TOOLS/orca_6_0_1_linux_x86-64_shared_openmpi416.run

# 6. Agregar el ejecutable de ORCA al PATH del sistema. 
# La ruta se basa en la instalación como usuario no-root
ENV PATH="/home/${USERNAME}/orca_6_0_1:${PATH}"

# 7. (Opcional) Instalar dependencias de Python si tienes un requirements.txt
# COPY --chown=$USERNAME:$USERNAME ./requirements.txt .
# RUN pip3 install --no-cache-dir -r requirements.txt

# 8. Iniciar un shell de bash al ejecutar el contenedor para que puedas trabajar interactivamente
CMD ["bash"]