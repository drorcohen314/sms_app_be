#!/bin/bash

# Custom commands to run during release phase
bundle install
rails db:schema:load RAILS_ENV=production
rails db:migrate RAILS_ENV=production