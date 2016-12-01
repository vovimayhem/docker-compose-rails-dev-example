# This Dockerfile is intended to build a production-ready app image.
# 1: Use ruby 2.2.6 as base:
FROM ruby:2.2.6-alpine

# 2: We'll set the application path as the working directory
WORKDIR /usr/src/app

# 3: We'll add the app's binaries path to $PATH, and set the environment name to 'production':
ENV PATH=/usr/src/app/bin:$PATH RAILS_ENV=production RACK_ENV=production

# 4: Set the default command:
CMD [ "bundle", "exec", "puma", "--bind", "tcp://0.0.0.0:3000" ]

# 5: Expose the web port:
EXPOSE 3000

# ==================================================================================================
# 6:  Install dependencies:

# 6.1: Install the common runtime dependencies:
RUN set -ex && apk add --no-cache libpq ca-certificates openssl

# 6.2: Copy just the Gemfile & Gemfile.lock, to avoid the build cache failing whenever any other
# file changed and installing dependencies all over again - a must if your'e developing this
# Dockerfile...
ADD ./Gemfile* /usr/src/app/

# 6.3: Install build dependencies AND install/build the app gems:
RUN set -ex \
  && apk add --no-cache --virtual .app-builddeps build-base postgresql-dev \
  && bundle install --without development test \
  && apk del .app-builddeps

# ==================================================================================================
# 7: Copy the rest of the application code, install nodejs as a build dependency, then compile the
# app assets, and finally change the owner of the code to 'nobody':
ADD . /usr/src/app
RUN set -ex \
  && apk add --no-cache --virtual .app-builddeps nodejs=6.2.0-r0 \
  && mkdir -p /usr/src/app/tmp/cache \
  && mkdir -p /usr/src/app/tmp/pids \
  && mkdir -p /usr/src/app/tmp/sockets \
  && DATABASE_URL=postgres://postgres@example.com:5432/fakedb \
  AMQP_URL=amqp://guest:guest@amqp:5672 TWITTER_API_KEY=SOME_KEY TWITTER_API_SECRET=SOME_SECRET \
  SECRET_KEY_BASE=10167c7f7654ed02b3557b05b88ece \
  rails assets:precompile \
  && echo "apk del .app-builddeps" \
  && chown -R nobody /usr/src/app

# ==================================================================================================
# 8: Set the container user to 'nobody':
USER nobody
