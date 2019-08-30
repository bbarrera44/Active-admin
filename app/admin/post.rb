ActiveAdmin.register Post do
  #index download_links: false
  index download_links: [:pdf, :csv]

    csv do
      column('title', humanize_name: false)
      column('name', humanize_name: false)
      column('content', humanize_name: false)

    end
  #--------------------------------------
  #config.paginate = false para desactivar el indice
  config.sort_order = 'title_asc' #orden
  config.per_page = [1, 2, 100]
#includes :emai
  #scope_to :admin_user, if: proc{ admin_user.limited_access? }
  permit_params :title, :content, :name, :image
  actions :all, except: [:destroy]
  menu parent: 'blog'

  show do
    panel 'Table of contents' do
    table_for post do
      column :title
      column :image do |ad|
      image_tag ad.image.to_s
      end
      column :content
      column :name
    end
  end
    active_admin_comments
  end


  sidebar "Details", only: :show do
  attributes_table_for post do
    row :limited_access
    row :updated_at
    row :created_at
    #row('limited_access?') { |b| status_tag b.limited_access }
  end
end
#contenido de aytuda al lado de la pagina
sidebar :help do
  ul do
    li "Need help? Email us at ejemplo@ejemplo.com"
    li "ayuda2"
  end
end

#   sidebar :help, if:proc{post.limited_access?} do
#     "Limited access Administrador"
#   end
# member_action :new, method: [:post] do
#   if request.post?
#     resource.update_attriburtes! new: params[:id] || {}
#     head :ok
#   else
#     render :new
#   end
# end
  #boton
  action_item :view, only: :show do
    link_to "Projects", admin_project_path(post) if post.present?
  end
#textosubmenu
  action_item :super_action,
              only: :show,
              if: proc{ post.limited_access? } do
    'Welcome Administrator'
  end

  index do
    id_column
    column :name
    column :title
    column :content
    column :limited_access
    para poner imagenes
    column "image" do |post|
      image_tag post.image.image_url, size: "50x50"
    end
    actions
  end

  filter :image, as: :check_boxes #selector
  filter :title, as: :check_boxes, collection: proc {Post.all}
  #filter :name, filters: [:starts_with, :ends_with]
  #filter :name_equals
  #filter :name_contains #mejor
  filter :name, label: 'Nombreeeee'




  index as: :grid do |product|
    link_to image_tag(product.image_was), admin_post_path(product)
  end



  # menu if: proc{ admin_user.edit_posts? }
  controller do
    # def scoped_collection
    #   end_of_association_chain.where(limited_access: true)
    # end
    #
    #
    # def find_resource
    #     scoped_collection.where(id: params[:id]).first!
    # end

    #accion de indice
    before_action only: :index do
      @per_page = 1
    end

    def edit
      # Good
      @post = Post.new(permitted_params[:post])
      # Bad
      @post = Post.new(params[:post])

      if @post.save
        # ...
      end
    end

    def new
      # Good
      @post = Post.new(permitted_params[:post])
      # Bad
      @post = Post.new(params[:post])

      if @post.save
        # ...
      end
    end

    def show
      @post = Post.find(params[:id])
    end
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


