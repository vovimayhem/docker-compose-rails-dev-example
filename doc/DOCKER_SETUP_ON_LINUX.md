# Recommended Docker setup on Linux

FYI: I always use Linux Mint and everything works out hassle-free. Here's how to
do it for Ubuntu-like distros:

## 1. Install Docker

*Please refer to the [Official Docker installation guides](http://docs.docker.com/installation/#installation)
for updated instructions for your linux distribution.*

```bash
# Log into your Ubuntu installation as a user with sudo privileges.

# Verify that you have wget installed.
which wget

# If wget isn't installed, install it after updating your manager:

sudo apt-get update $ sudo apt-get install wget

# Get the latest Docker package.

wget -qO- https://get.docker.com/ | sh

# Verify docker is installed correctly.

sudo docker run hello-world
```

## 2. Adding your user to the docker group

Using sudo everytime is kind of tiresome. Do yourself a favor and add your user
to the `docker` group:

```bash
# Please replace 'your_user' with your actual user name:
sudo usermod -a -G docker your_user

# Check that you belong to the docker group:
id
# You should be able to see the docker group entry. If not...
```

*CAVEAT* I've seen some Ubuntu systems that require you to logout and then log
back in in order for you to appear belonging in the `docker` group.

## 3. Install Docker Compose

*Please refer to the [Official Docker Compose installation guide](https://docs.docker.com/compose/install/#install-compose)
for updated instructions.*

To install Docker Compose, run the following command:

```bash
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```
