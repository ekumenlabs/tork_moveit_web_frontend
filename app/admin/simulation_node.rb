ActiveAdmin.register SimulationNode do

  actions :index, :show

  includes :user

  index do
    id_column
    column :address
    column "User" do |simulation_node|
      user = simulation_node.user
      link_to user.email, admin_user_path(user)
    end
    column :created_at
    column :updated_at
    actions do |simulation_node|
      item "Unschedule", "", class: "member_link"
    end
  end

  filter :address
  filter :created_at
  filter :updated_at

end
