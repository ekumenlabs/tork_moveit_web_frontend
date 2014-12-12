class NoSimulationNodesLeft < StandardError
end

class SimulationNodeScheduler

  # Answer true if we can spawn a new EC2 node for this user
  def can_schedule_new_node_for(user)
    SimulationNode.count < max_simulation_nodes
  end

  # Schedule a new simulation node for a user
  # Throw NoSimulationNodesLeft if there is none available
  def schedule_new_node_for!(user)
    raise NoSimulationNodesLeft unless can_schedule_new_node_for(user)
    node_address = launch_ec2_node()
    # Make sure next time user.simulation_node is called it has the new node associated
    user.clear_association_cache
    SimulationNode.create!({address: node_address, user: user})
  end

  # Schedule a new simulation node for a user
  # Throw NoSimulationNodesLeft if there is none available
  def unschedule_node(simulation_node)
    Rails.logger.info("Shutting down node #{simulation_node.id} in #{simulation_node.address}")
    shut_down_ec2_node(simulation_node.address)
    simulation_node.destroy
  end

  # Check for simulation nodes that have been scheduled but that have
  # been idle more than the allowed time
  def garbage_collect
    SimulationNode.transaction do
      SimulationNode.idle.each do |node|
        Rails.logger.info("Garbage-collecting node #{node.id}")
        unschedule_node(node)
      end
    end
  end

  protected

  # The maximum number of nodes that we are allowed to spawn
  def max_simulation_nodes
    rwt_moveit_config[:max_simulation_nodes]
  end

  # In the future this method will launch an actual EC2 node and start
  # the moveit processes there.
  # Assuming a sync process, although this will be very likely async.
  # Returns a string in the form <ip:port>
  def launch_ec2_node
    "#{rwt_moveit_config[:host]}:#{rwt_moveit_config[:port]}"
  end

  # Do nothing right now. In the future we would trigger a
  # node shutdown
  def shut_down_ec2_node(address)
  end

  def rwt_moveit_config
    MoveitWebFrontend::Application.config.rwt_moveit
  end

end
