# This Dockerfile is intended to build a production-ready app image.
#
# This is not required for development environments, which could use another
# image such as 'vovimayhem/dev-stack:ruby-2.2'

# TODO: Create the image that is used as a base for this!
FROM vovimayhem/app-container:ruby-2.2
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

# Copy the rails app:
COPY . /app

# Run bundle install --deploy:
RUN bundle install --deploy

# Remove unused files as root:
USER root

# TODO: Actually remove the usued files, such as compilers, development source
# code headers, etc:
# - see https://blog.jtlebi.fr/2015/04/25/how-i-shrunk-a-docker-image-by-98-8-featuring-fanotify/
RUN echo 'Doing something...'

# Revert back to the 'app' user:
USER app

# Run the app in production mode by default:
ENV RACK_ENV=production RAILS_ENV=production

# Specify the default container command:
CMD ["rails s -p 0.0.0.0"]
