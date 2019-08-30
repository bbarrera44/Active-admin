ActiveAdmin.register Ticket do
  permit_params :name, :value


  form title: 'A custom title' do |f|
    inputs 'Details' do
      input :name
      input :value, label: "public"
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      input
      panel 'Markup' do
        "The following"
      end
      inputs 'Content', :body

    end
  end
  show do
    panel "post details" do
      attributes_table_for post do
        row :id
        row :'Post' do
          post.posts.each do |tag|
            a tag, href: admin_post_path(q: {tagged_with_contains: tag})
            text_node "&nbsp:".html_safe
          end
        end
      end
    end
  end

  csv force_quotes: true, col_sep: " :el texto sigue", column_names: false do
    column :name
    column(:value).to_s {|post| post.value.full_name}

  end



  controller do

    # def scoped_collection
    #   end_of_association_chain.where(limited_access: true)
    # end


    # def find_resource
    #   scoped_collection.where(id: params[:id]).first!
    # end

        def show
          @post = Post.find(params[:id])
        end

    def new
      # Good
      @ticket = Ticket.new(permitted_params[:post])
      # Bad
      @ticket = Ticket.new(params[:post])

      if @ticket.save
        # ...
      end
    end
    def set_project
      @ticket = Ticket.find(params[:id])
    end
  end

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
# end

end
