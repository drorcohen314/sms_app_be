#!/bin/bash

# Custom commands to run during release phase
bundle install
rails db:migrate RAILS_ENV=production
