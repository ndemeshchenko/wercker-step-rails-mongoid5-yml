#!/usr/bin/env bash

main() {
  local mongoid_yml_path="$PWD/config/mongoid.yml"

  if [ -f "$mongoid_yml_path" ]; then
    debug 'config/mongoid.yml already exists and will be overwritten'
  fi

  if [ -z "$MONGO_PORT_27017_TCP_ADDR" ]; then
    warn "MONGO_PORT_27017_TCP_ADDR env var for the mongo service is not set"
    return
  fi

  if [ -z "$MONGO_PORT_27017_TCP_PORT" ]; then
    warn "MONGO_PORT_27017_TCP_ADDR env var for the mongo service is not set"
    return
  fi

  if [ -z "$WERCKER_RAILS_MONGOID_YML_DB_NAME" ]; then
    local db_name_default='mongoid'
    debug "option db_name not set, defaulting to $db_name_default"
    export WERCKER_RAILS_MONGOID_YML_DB_NAME="$db_name_default"
  fi

  info "exporting MONGOID_ENV='test' as a fallback"
  export MONGOID_ENV='test'
  info "Generating mongoid.yml template"
  mkdir -p "$(dirname "${mongoid_yml_path}")"
  tee "$mongoid_yml_path" << EOF
test:
  clients:
    default:
      database: <%= ENV['WERCKER_RAILS_MONGOID_YML_DB_NAME'] %>
      hosts:
        - <%= ENV['MONGO_PORT_27017_TCP_ADDR'] %>:<%= ENV['MONGO_PORT_27017_TCP_PORT'] %>
      options:
        read:
          mode: :primary
        max_retries: 1
        retry_interval: 0
  options:
      raise_not_found_error: false
EOF
}

main;
