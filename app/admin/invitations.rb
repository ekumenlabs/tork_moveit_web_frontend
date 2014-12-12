ActiveAdmin.register User, :as => 'Invitation' do

  actions :index, :show

  # Users and invitations are part of the same model. Only show those users
  # that haven't accepted the invitation
  controller do
    def scoped_collection
      end_of_association_chain
        .where('invitation_token IS NOT NULL AND invitation_accepted_at IS NULL')
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :invitation_created_at
    column :invitation_sent_at
    column :invitation_token
    actions
  end

  filter :email
  filter :account
  filter :invitation_created_at
  filter :invitation_sent_at

  action_item do
    link_to 'Invite New User', new_invitation_admin_invitations_path
  end

  collection_action :new_invitation do
    @user = User.new
  end

  collection_action :send_invitation, :method => :post do
    @user = User.invite!(params[:user], current_user)
    if @user.errors.empty?
      flash[:success] = 'User has been successfully invited.'
      redirect_to admin_invitations_path
    else
      messages = @user.errors.full_messages.map { |msg| msg }.join
      flash[:error] = 'Error: ' + messages
      redirect_to new_invitation_admin_invitations_path
    end
  end

end
