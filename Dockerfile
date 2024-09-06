# Use the Fedora base image, please use LTS version.
FROM fedora:40

# Install OpenSSH server and other packages
RUN dnf update -y && \
    dnf install -y openssh-server \
                   python3 \
                   python3-libs \
                   git \
                   gcc \
                   neovim \
                   ripgrep \
                   fd-find \
                   ranger && \
    dnf clean all

# Explicitly set the shell to bash, otherwise pnpm will not work and need to
# be installed with `SHELL=$SHELL pnpm setup` inside the container.
SHELL ["/bin/bash", "-c"]
RUN npm install --global pnpm \
    && SHELL=bash pnpm setup \
    && source /root/.bashrc

# Set a root password
RUN echo 'root:password' | chpasswd

# ========== This section to be use volume to persist config instead ===========
# # Copy Ranger configuration files into the container
# COPY ./config/ranger /root/.config/ranger

# # Copy Neovim configuration files into the container
# COPY ./config/nvim /root/.config/nvim
# ==============================================================================

# Generate SSH host keys
RUN ssh-keygen -A

# Expose SSH port for vscode
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]


## ============= Basic commands to build and run the container =================
## Build the image
# docker build -t fedora-dev:40 .

## Run the container with sshd server
# docker run -d -p 2222:22 -v ./config:/root/.config --name fedora-dev fedora-dev:40
## without volume
# docker run -d -p 2222:22 --name fedora-dev fedora-dev:40

## Single run with bash
# docker run -it --rm -v ./config:/root/.config fedora-dev:40 /bin/bash

## Save the image as a tar file
# docker save -o fedora-dev.tar fedora-dev:40

## Load the image from a tar file
# docker load -i fedora-dev.tar

## Steps to create a Docker image from a running container, preserving its current state.
# 1. Run the container
# docker run -d -p 2222:22 --name fedora-dev fedora-dev:40
# 2. Enter the container and make any changes
# docker exec -it fedora-dev /bin/bash
# 3. Commit the changes to a new image
# docker commit fedora-dev fedora-dev:40
# 4. ou can also add tags and descriptions to your new image to better identify it:
# docker commit -m "Preserv installed nvim plugin state" -a "Your Name" fedora-dev fedora-dev:40
