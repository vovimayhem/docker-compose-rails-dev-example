# Recommended Docker setup on Mac OSX

Since Linux containers can't run directly on Mac yet, you'll need to use
virtualization software in order to fire up a virtual server running a lightweight
OS special for running Docker - That's taken care of with [Docker Machine](https://docs.docker.com/machine/)

*Be advised* that the official Docker docs still instructs to fire up a virtual
machine running boot2docker manually, and makes you set up a bunch of environment
variables by yourself. *Disregard that information*, since
[Docker Machine](https://docs.docker.com/machine/) already takes care of this!

## 1. Install virtualization software

Although [Docker Machine](https://docs.docker.com/machine/) supports
[Virtualbox](https://www.virtualbox.org/) for creating and managing Docker hosts,
*I strongly advise against using it*, since it doesn't work well quite often, and
when it does, offers inferior performance than [VMWare Fusion 7+](http://www.vmware.com/products/fusion),
which I do recommend.

## 2. Install Docker Machine

*Please refer to the [Official Docker Machine installation guide](https://docs.docker.com/machine/#osx-and-linux)
for updated instructions.*

```bash
# Install Docker Machine:
curl -L https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_darwin-amd64 > /usr/local/bin/docker-machine
chmod +x /usr/local/bin/docker-machine

# Install the Docker client, which issues the docker commands to your virtualized docker host:
curl https://get.docker.com/builds/Darwin/x86_64/docker-latest > /usr/local/bin/docker
```

## 3. Create a virtualized Docker host with Docker Machine

```bash
# Create a virtualized Docker host called 'dev' with VMWare Fusion:
docker-machine --debug create --driver vmwarefusion dev

# If you encounter problems with Docker server/client version mismatch
# (that's the case with the current version - remember it's still in Beta),
# try specifying the boot2docker image url:
docker-machine create --driver vmwarefusion \
--vmwarefusion-boot2docker-url https://github.com/cloudnativeapps/boot2docker/releases/download/v1.6.0-vmw/boot2docker-1.6.0-vmw.iso \
dev

# Add the required environment variables to your terminal environment:
eval $(docker-machine env dev)
```

## 4. Install Docker Compose

*Please refer to the [Official Docker Compose installation guide](https://docs.docker.com/compose/install/#install-compose)
for updated instructions.*

Try installing via curl first - You'll need an updated Python install for this:

```bash
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Check your installation:
docker-compose --version
```

If for any reason this does not work, try installing via PIP:
```bash
sudo pip install -U docker-compose
```
