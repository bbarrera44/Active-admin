 ActiveAdmin.register Project do
   ActiveAdmin::AsyncExport.from_email_address = 'admin@topshelfclothes.com'

   permit_params :name, :active, :user
   index download_links: [:pdf, :csv, :email]


  batch_action :flag do |selection|
  Project.find(selection).each { |p| p.flag!}
  redirect_to collection_path, :name => "ejemplo flag"
  end

   show do
     panel 'Table ' do
     table_for post do
     column :name
     column :active
     column :user
     end
     end
     #active_admin_comments
   end

   index do
     #column :name
     column :active
     column :user
     toggle_bool_column :active
     actions
   end


   # sidebar "Project Details", only: [:show, :edit, :new] do
   #   ul do
   #     li link_to "Tickets", admin_ticket_path(resource)
   #     li link_to "Post", admin_post_path(resource)
   #   end
   # end
   controller do

     def show
       @post = Post.find(params[:id])
     end
   end
 end



 ActiveAdmin.register Ticket do
   belongs_to :project, optional: true
 #  navigation_menu :project

 end

 ActiveAdmin.register Post do
   belongs_to :project, optional: true
  # navigation_menu :project

 end

#   sidebar "ticket details", only: [:show, :edit] do
#     ul do
#       li link_to "tickets", admin_ticket(resource)
#       li link_to "Milestones", admin_admin_user_path(resource)
#     end
#   end
# end
# ActiveAdmin.register Post do
#   belongs_to :project
#   navigation_menu :project
# end
# ActiveAdmin.register Ticket do
#   belongs_to :project
#   navigation_menu :project
# end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted



