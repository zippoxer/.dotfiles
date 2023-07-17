FROM ubuntu:22.04

# Install sudo
RUN apt-get update -y && apt-get install -y sudo

# Copy your script into the Docker container
COPY . /root/.dotfiles

# Run your installation script
RUN /root/.dotfiles/install.sh

CMD ["/bin/zsh"]