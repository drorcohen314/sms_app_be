#!/bin/bash

# Custom commands to run during release phase
bundle install
rails db:create RAILS_ENV=production
rails db:migrate RAILS_ENV=production
cd storage
ls
