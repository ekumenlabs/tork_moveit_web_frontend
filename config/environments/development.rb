Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Devise mailer configuration
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.rwt_moveit = {
    # HOST + PORT where rwt_moveit is running. This will be removed when we have
    # dynamic EC2 node allocation
    host: '192.168.1.103',
    port: '9090',
    # The max number of simulation nodes that we can spawn
    max_simulation_nodes: 1,
    # Interval at which a client in a simulation page will send a ping to the server
    ping_interval: 15.seconds,
    # Interval at which a client in a simulation page will send a ping to the server
    # if the previous ping failed
    retry_ping_interval: 5.seconds,
    # Interval at which we ask the scheduler to garbage collect idle nodes
    node_garbage_collection_interval: 45.seconds,
    # The time that has to elapse to consider a node idle
    node_max_idle_time: 30.seconds
  }
end
