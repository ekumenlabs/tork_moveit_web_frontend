ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation

  # Users and invitations are part of the same model. Only show those users
  # that have accepted the invitation
  controller do
    def scoped_collection
      end_of_association_chain
        .where('invitation_token IS NULL OR invitation_accepted_at IS NOT NULL')
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :sign_in_count
    column :current_sign_in_at
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :sign_in_count
  filter :current_sign_in_at
  filter :created_at
  filter :updated_at

  show do
    attributes_table :email,
      :created_at,
      :updated_at,
      :sign_in_count,
      :current_sign_in_at,
      :current_sign_in_ip,
      :last_sign_in_at,
      :last_sign_in_ip,
      :failed_attempts,
      :locked_at,
      :unlock_token,
      :reset_password_token,
      :reset_password_sent_at,
      :remember_created_at,
      :invitation_token,
      :invitation_created_at,
      :invitation_sent_at,
      :invitation_accepted_at,
      :invitation_limit,
      :invited_by_id,
      :invited_by_type,
      :invitations_count
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
