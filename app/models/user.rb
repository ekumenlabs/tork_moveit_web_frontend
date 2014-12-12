class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :rememberable, :omniauthable
  devise :invitable,
         :database_authenticatable,
         :recoverable,
         :registerable,
         :trackable,
         :timeoutable,
         :lockable,
         :validatable

  # Note: simulation nodes are created on user login and destroyed on user log-out
  # (or when we detect that the user is no longer in the app).
  has_one :simulation_node

  def has_simulation_node?
    !simulation_node.nil?
  end

  # This is called by the session management framework when the user logs out.
  # Tell the scheduler to un-schedule the assigned node if any.
  def release_simulation_node
    scheduler.unschedule_node(simulation_node) if has_simulation_node?
    clear_association_cache
  end

  # Retrieve an existing simulation node or create a new one
  # if absent
  def scheduled_simulation_node
    scheduler.schedule_new_node_for!(self) unless has_simulation_node?
    simulation_node
  end

  # This is called after the user has been successfully authenticated.
  # Perform a node GC to see if we can get earlier an idle node.
  def after_database_authentication
    scheduler.garbage_collect
  end

  protected

  def scheduler
    SimulationNodeScheduler.new
  end

end
