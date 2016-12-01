# Create a new Rails project using Docker

While this docker-compose project is really good for firing up an already-existing Rails app,
creating a new Rails app with it is a lot easier using plain docker.

There should be a lot of rails project templates out there, but here we'll go *"back to basics"*.
We'll install rails temporarily on a one-off container (using the `docker` command directly, instead
of `docker-compose`), from which we'll call the rails project generator:

```bash
# Start a new, one-off ruby container running a bash shell. It should have the
# current directory mounted at '/usr/src':
docker run --rm -ti -v $(pwd):/usr/src -w /usr/src ruby:2.2.6 bash

# Now that your'e running bash inside our one-off container, install rails and generate the app.
gem install rails --no-rdoc --no-ri && rails new my-app --database=postgresql

# Exit the one-off container. The container should be removed automatically.
exit
```

Now you have your new rails project code created and available in your host.
