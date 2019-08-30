ActiveAdmin.register AdminUser do
#===================================================== import
  action_item :import_users,  only: :index do
  link_to "Import_users", import_form_admin_admin_users_path
  end

  collection_action :import_form, title: "Import Users" do
  end

  collection_action :import, title: "Import Users", method: :post do
  end

  collection_action :import_users, title: "Import Users", method: :post do
    file_path = admin_jobs_path(params[:data][:source])
    UserUploadJob.perform_later(current_admin_user.job_identifier, file_path)
  end

#==========================================
  permit_params :email, :password, :password_confirmation
  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
