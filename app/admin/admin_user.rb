ActiveAdmin.register AdminUser do

  active_admin_import validate: false,
                      template: 'import' ,
                      template_object: ActiveAdminImport::Model.new(
                       hint: "extructura del archivo:  'email', 'password'",
                       allow_archive: false
  )
  sidebar :help do
    ul do
      li "archivo con extencion csv"
    end
  end
  sidebar :help_import_csv, if: proc{:index} do
    "exportar archivo csv"
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

  controller do

    def do_import
      file = params[:active_admin_import_model]['file'].path
      if file.present?
        data = File.read(file)
        csv = CSV.new(data, :headers => true, :header_converters => :symbol, :converters => [:all])
        records = csv.to_a.map {|row| row.to_hash}
        records.each do |record|
          data_types = AdminUser.find_by_email(record[:email])
          if data_types.present?
            data_types.update(
                email: record[:email],
                password: record[:password]
            )
          else
            data_types =  AdminUser.new(
                email: record[:email],
                password: record[:password]
            )
            data_types.save
          end
          flash[:notice] = "cargados con éxito"
        end
        redirect_to admin_admin_users_path
      end
    end
  end
  end

  ActiveAdmin.register Post do
    belongs_to :admin_user, optional: true
    # navigation_menu :project

  end



