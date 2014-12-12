require 'rufus-scheduler'

# Only schedule the GC if running in a server (i.e. not in the CLI console)
# and not in a test environment
if defined?(Rails::Server) && !Rails.env.test?

  scheduler = Rufus::Scheduler.singleton
  interval = MoveitWebFrontend::Application.config.rwt_moveit[:node_garbage_collection_interval]

  Rails.logger.info("Scheduling node garbage collection every #{interval} seconds")

  scheduler.every "#{interval}s"  do
    SimulationNodeScheduler.new.garbage_collect
  end

end
