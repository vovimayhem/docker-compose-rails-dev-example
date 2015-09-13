-- This file is a reference to replicate a freshly-provisioned database like most
-- database service providers - such as Heroku Postgres, for example.

-- I think including these instructions as rails migrations is not a good fit,
-- since you already get this taken care of by the database provider anyways.
-- I'm open to discussion, however :)

-- Enable HStore:
CREATE EXTENSION hstore;

-- Enable DBLink:
CREATE EXTENSION dblink;

-- Create the project databases:
CREATE DATABASE xmple_development;
CREATE DATABASE xmple_test;
