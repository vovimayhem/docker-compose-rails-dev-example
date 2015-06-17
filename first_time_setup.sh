#! /bin/bash
################################################################################
# This simple bash file is intended to be run after the cloning/checking-out
# of the project, and does the following:
#
#   1. Generating the '/.env' file from the template ('/dotenv-template.env')
#   2. Generating the app's 'config/secrets.yml' file from the template ('/rails-secrets-template.yml.erb')
#   3. Run the 'bundler' command to install the app dependencies in the app container.
#   4. Run the 'rake db:migrate' command to initialize the database.
WORKSPACE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DOTENV_TEMPLATE_FILE=$WORKSPACE_DIR/lib/templates/dotenv.env
DOTENV_FILE=$WORKSPACE_DIR/.env
RAILS_SECRETS_TEMPLATE_FILE=$WORKSPACE_DIR/lib/templates/secrets.yml.erb
RAILS_SECRETS_FILE=$WORKSPACE_DIR/config/secrets.yml

# 1: Generate the .env file:
if [ ! -e "$DOTENV_FILE" ] ; then
    cat $DOTENV_TEMPLATE_FILE > $DOTENV_FILE
fi

# 2: Generate the app's 'config/secrets.yml' file:
if [ ! -e "$RAILS_SECRETS_FILE" ] ; then
    cat $RAILS_SECRETS_TEMPLATE_FILE > $RAILS_SECRETS_FILE
fi

# 3: Call 'bundler' in any of the app containers (web, worker, test).
# It will also start the dependency containers (postgres, redis), which
# we'll need them already running for the next step:
docker-compose run --rm web bundle

# Wait 20 seconds for the postgres container to finish initializing:
read -t 20 -p "Waiting 20 seconds for the postgres container to finish initializing (Hit ENTER to continue right away)"
echo " - Continuing with app database setup:"

# 4: Call 'rake db:setup' to initialize the app database with the needed tables
# & data:
docker-compose run --rm web rake db:setup

# 5: Stop all the running containers:
docker-compose stop
