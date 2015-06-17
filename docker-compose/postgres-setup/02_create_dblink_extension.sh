# https://github.com/aidanlister/postgres-hstore/blob/master/create_extension.sh
# Because both template1 and the user postgres database have already been created,
# we need to create the hstore extension in template1 and then recreate the postgres database.
#
# Running CREATE EXTENSION in both template1 and postgres can lead to
# the extensions having different eid's.

echo "Initialization file at:";
echo " - [compose-project]/volumes/postgres/docker-entrypoint-initdb.d/02_create_dblink_extension.sh";
echo "Operation: CREATING POSTGRESQL DBLINK EXTENSION";

gosu postgres postgres --single template1 -E <<-EOSQL
  CREATE EXTENSION dblink;
EOSQL

echo "";
echo "POSTGRESQL DBLINK EXTENSION CREATED";
