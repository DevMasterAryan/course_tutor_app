#!/bin/bash
set -e

# Install dependencies
bundle install

# Wait for database
until bundle exec rails runner "ActiveRecord::Base.connection.execute('SELECT 1')" > /dev/null 2>&1; do
  echo "Waiting for database..."
  sleep 1
done

# Setup database
bundle exec rails db:create || true
bundle exec rails db:migrate

# Start server
exec bundle exec rails server -b 0.0.0.0
