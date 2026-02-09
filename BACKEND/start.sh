#!/bin/bash
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake assets:precompile
bundle exec puma -C config/puma.rb