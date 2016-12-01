# Example of a Rails App with Docker Compose for development

This is an example of how I use [Docker](https://docs.docker.com/) and
[Docker Compose](https://docs.docker.com/compose/) to develop my rails apps.

It is an ideal project setup for new and experienced developers alike, and allows
to a nearly trouble-free environment setup in their development machines.

In this example we'll fire up a full app environment consisting of the following:

 - A [postgres container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L17)
 which hosts the app's database.
 - A [redis container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L38)
 which hosts the app's job queue.
 - An example Rails app running 3 processes on separate containers:
   - A [`jobs` container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L51)
   running the app's job processor ([Sidekiq](http://sidekiq.org/)).
   - A [`worker` container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L105)
   running the Rails web server.
   - A [`test` container](https://github.com/vovimayhem/docker-compose-rails-dev-example/blob/master/docker-compose.yml#L113)
   running [guard](http://guardgem.org/), which fires tests automatically whenever a change in the
   app code is detected.

You'll need to follow some instructions to get this example running:

## 1: Requirements

You must have [Docker](https://docs.docker.com/) and
[Docker Compose](https://docs.docker.com/compose/) on your machine.

You can install these with:
  * [Docker for Mac](https://docs.docker.com/docker-for-mac/) on macOS
  * [Docker for Windows](https://docs.docker.com/docker-for-windows) on Windows

## 2: 'Clone & Run' the project

You should clone the project into a conveniently-named directory, as this repo's name is big enough
to make typing docker/compose commands tiresome, should the need arise:

```
git clone https://github.com/vovimayhem/docker-compose-rails-dev-example.git example \
  && cd example \
  && docker-compose up -d web jobs \
  && docker-compose logs -f
```

Watch it as it starts all the containers, and how the app database is initialized upon the first run
before starting the rails web server.

## 3: NOT ANYMORE: Initialize the app environment in an initial run:

Originally there was some setup to be made prior to running the app. Fortunately a lot of changes
happened since then, and although the dotenv file is recommended, it is not required for the project
to run immediately after cloning.

If you need to, however, you can copy the contents of the example dotenv file into a file
called `.env`:

```
cp example.env .env
```

Docker Compose now reads the `/.env` file by default, if it exists. You can still add other dotenv
files and reference them in the `docker-compose.yml` file, but that would require an additional step
than the coveted 'clone and run' project setup.

## 4: Bring online the project's containers

```
docker-compose up -d
```

That's it! Check the running app web interface: [http://localhost:3000](http://localhost:3000)

## 5: Next steps

I usually do some tricks to aid in my day to day activities:

### Modifying the `/etc/hosts` file for rails apps that depend on subdomains
Pretty self-explanatory.

### Generate aliases to the docker-compose command... or use Plis

The `docker-compose` commands are a bit lengthy for my taste, so I started generating some bash
aliases... eventually I created a small Go app called [Plis](https://github.com/IcaliaLabs/plis)
which besides having a smalled character count, it allows me to attach to any container using the
service name, which is a must to debug the app using `byebug`:

```
plis start web && plis attach web
# => Converts the commands to `docker-compose up -d web && docker attach example_web_1`
```

### Create a new rails project with Docker
[Create a new rails app using docker](doc/CREATE_A_NEW_RAILS_PROJECT.md), if you find yourself in
the need of creating a new app, and you are already running this example project.

## 6: Example app ruby version

It uses MRI ruby 2.2.6. I'll make some branches using different engines (i.e. Rubinius, JRuby)

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
