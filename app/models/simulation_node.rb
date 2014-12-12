class SimulationNode < ActiveRecord::Base
  belongs_to :user

  validates :user,   presence: true
  validates :address, presence: true, uniqueness: true

  def self.idle
    config = MoveitWebFrontend::Application.config.rwt_moveit[:node_max_idle_time]
    where('updated_at < ?', config.ago)
  end
end
