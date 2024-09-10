# Use the Fedora base image, please use LTS version.
FROM fedora:40

# Install OpenSSH server and other packages
#   - bc: Basic calculator, required by passion theme in oh-my-zsh.
RUN dnf update -y && \
    dnf install -y openssh-server \
                   python3 \
                   python3-libs \
                   git \
                   gcc \
                   curl \
                   zsh \
                   xclip \
                   xsel \
                   bc \
                   tmux \
                   neovim \
                   ripgrep \
                   ranger \
                   fd-find && \
    dnf clean all

# Create the 'khunbai' user and set as a sudoer without password required.
RUN useradd -ms /bin/bash khunbai && \
    echo 'khunbai ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    
# Explicitly set the shell to bash, otherwise pnpm will not work and need to
# be installed with `SHELL=$SHELL pnpm setup` inside the container.
ENV PNPM_HOME="/home/khunbai/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN npm install --global pnpm \
    && SHELL=bash pnpm setup \
    && source /home/khunbai/.bashrc

# Set a root password (you may want to reconsider security settings for production)
RUN echo 'root:password' | chpasswd

# Generate SSH host keys (done as root before switching users)
RUN ssh-keygen -A

# Set the 'khunbai' user as the default user
USER khunbai
WORKDIR /home/khunbai

# This to make sure ownership of the .local/share directory is correct
# when running the container with a volume mount. Otherwise, the .local
# will be owned by root when mounting with docker-compose.
RUN mkdir -p /home/khunbai/.local/share

# Set the pnpm store path to khunbai home directory.
RUN pnpm config set store-dir $PNPM_HOME

# Expose SSH port for vscode
EXPOSE 22

# Set Zsh as the default shell
SHELL ["/bin/zsh", "-c"]

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# Start SSH service, this is a long running process to keep the container active.
CMD ["sudo", "/usr/sbin/sshd", "-D"]


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
