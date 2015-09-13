# Example of a Rails App with Docker Compose for development

This is an example of how I use [Docker](https://docs.docker.com/) and
[Docker Compose](https://docs.docker.com/compose/) to develop my rails apps.

It is an ideal project setup for new and experienced developers alike, and allows
to a nearly trouble-free environment setup in their development machines.

In this example we'll fire up a full app environment consisting of the following:

 - A [postgres container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L3)
 which hosts the app's database.
 - A [redis container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L14)
 which hosts the app's job queue.
 - An example Rails app running 3 processes on separate containers:
   - A [`web` container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L22)
   running the Rails web server.
   - A [`worker` container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L62)
   running the app's job processor ([Sidekiq](http://sidekiq.org/)).
   - A [`test` container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L68)
   running [guard](http://guardgem.org/), which fires tests automatically whenever
   the app code changes. We'll *also* use this container to launch remote debugging
   sessions to the running [`web`](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L22)
   and [`worker`](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L62)
   containers.

You'll need to follow some instructions to get this example running:

## 1: Requirements

You must have both [Docker](https://docs.docker.com/) (or a
[Docker Machine](https://docs.docker.com/machine/) host) and
[Docker Compose](https://docs.docker.com/compose/) running on your machine.

You can find instructions for the recommended setup on
[Linux](doc/DOCKER_SETUP_ON_LINUX.md), [Mac OSX](doc/DOCKER_SETUP_ON_MAC.md) and
[Windows 8+](doc/DOCKER_SETUP_ON_WINDOWS.md).

## 2: Cloning the project

You should clone the project into a conveniently-named directory, as this repo's
name is big enough to make typing docker/compose commands tiresome, should the
need arise:

```bash
git clone https://github.com/vovimayhem/docker-compose-rails-dev-example.git example
```

## 3: Initialize the app environment in an initial run:

The `setup-development-with-docker.sh` script will do the following:
  1. Generate an `.env` file, into which we'll store sensitive info (passwords, SECRET_KEY_BASE, etc). *This file shouldn't be in version control*
  2. Generate the app's `config/secrets.yml` file, which will read the `SECRET_KEY_BASE` environment variable for all rails app environments.
  3. Run the `bundler` command to install the app dependencies in the app's `vendor/bundle` folder.
  4. Run the 'rake db:setup' command to initialize the database.

```bash
cd example && ./setup-development-with-docker.sh
```

Edit if you need the generated `.env` file.

## 4: Bring online the project's containers

```bash
docker-compose up -d
```

That's it! Check the running app web interface: [http://localhost:3000](http://localhost:3000)

## 5: Next steps

I usually do some tricks to aid in my day to day activities:

 - [Modify the `/etc/hosts` file for rails apps that depend on subdomains.](http://www.example.com)
 - [Generate aliases to the docker-compose command](http://www.example.com), as the `docker-compose` command tires my delicate fingers...
 - [Mess around with the compose commands](http://www.example.com) to start & stop the project's containers.
 - *VERY IMPORTANT* [Launch a remote debug session easily](http://www.example.com) to any of the project's app containers,
 as Docker makes debugging with byebug not so trivial.
 - [Running rails/rake commands on one-off containers](http://www.example.com), which is necessary quite often.
 - [Create a new rails app using docker](doc/CREATE_A_NEW_RAILS_PROJECT.md), if you find yourself in the need of creating a new app, and
 you are already running this example project.

## 6: Example app ruby version

It uses MRI ruby 2.2.2. I'll make some branches using different engines (i.e. Rubinius, JRuby)

## 7: More Information

 * [Everything Docker](https://docs.docker.com)
 * GIANT ROBOTS SMASHING INTO OTHER GIANT ROBOTS (Seriously, [thoughtbot](https://github.com/thoughtbot)?)
 * [Introducing 'heroku docker:release': Build & Deploy Heroku Apps with Docker](https://blog.heroku.com/archives/2015/5/5/introducing_heroku_docker_release_build_deploy_heroku_apps_with_docker)
 geez! These guys are on EVERYTHING!

## 8: Contributing

I'd love to receive feedback & suggestions from everyone. If you see something off,
or think there's a better way to do something this thing does, please do:

 * Fork the original repository.
 * Make your changes in a topic branch.
 * Send a pull request.

# License

This is free software, and may be redistributed under the terms specified in the [LICENSE](LICENSE) file.
