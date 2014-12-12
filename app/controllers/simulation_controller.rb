class SimulationController < ApplicationController
  # Devise authentication
  before_action :authenticate_user!

  def index
    begin
      @node = current_user.scheduled_simulation_node
    rescue NoSimulationNodesLeft => exception
      render :no_simulation_nodes_left
    end
  end

  def ping
    if current_user.has_simulation_node?
      current_user.simulation_node.touch
    end
    render json: 'Ok'.to_json
  end

end
