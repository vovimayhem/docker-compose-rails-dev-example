# Create a new Rails project using Docker

While this docker-compose project is really good for firing up an already-existing
Rails app, creating a new Rails app with it is a bit tricky, if not possible.

There should be a lot of rails project templates out there, but here we'll go
*"back to basics"*. We'll install rails temporarily on a one-off container
(using the `docker` command directly, instead of `docker-compose`), from which
we'll call the rails project generator:

```bash
# Create our new app directory, and move into it:
mkdir our-new-app && cd our-new-app

# Start a new, one-off ruby container running a bash shell. It should have the
# current directory mounted at '/workspace':
docker run --rm -t -i -v $(pwd):/our-new-app vovimayhem/dev-stack:ruby-2.2 bash

# Inside our container, change to our mounted directory, install rails, and
# generate the rails project.
#
# Note that we'll skip running bundle here, as we'll need to run bundler anyways
# in a container started with `docker-compose`.
cd /our-new-app \
&& gem install rails --no-rdoc --no-ri \
&& rails new . --database=postgresql --skip-bundle

# Exit the one-off container. The container should be removed automatically.
exit
```

Now you have your new rails project code created and available in your host.
