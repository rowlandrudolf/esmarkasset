class DocumentsController < ApplicationController
  
  before_action :validate_model_type!

  def index
  	@documents = klass.all
  	# authorize user unless klass.is_a?(Article)
  end

  def new
  	@document = klass.new()
  	@document.user = current_user 
    # authorize user && user.admin?
  end

  def create
  	@document = klass.new(document_params)
  	@document.user = current_user 
    # authorize user && user.admin?
  	if @document.save
      redirect_to documents_url, notice: 'Document Added.'
    else
      render :new
    end

  end

  def edit
    @document = klass.find(params[:id])
    # authorize user && user.admin?
  end

  def update
  	@document = klass.find(params[:id])
    # authorize user && user.admin?
  	if @document.update(document_params)
  	  redirect_to documents_url, notice: 'Document Updated.'
  	else
      render :edit 
  	end
  end

  def destroy
  	document = klass.find(params[:id])
    # authorize user && user.admin?
  	document.destroy
  	redirect_to documents_url
  end

private

  def resources
    @resources ||= request.path.slice(/[a-zA-Z]+/)
  end
  
  def model_name
    @model_name ||= resources.capitalize.singularize if resources
  end

  def validate_model_type!
    unless Document.types.include?(model_name)
      redirect_to root_url, notice: 'Invald document request'
    end
  end

  def klass
    model_name.constantize
  end

  def document_params
    params.require(model_name.downcase.to_sym).permit(:title,:author,:date,:description,:attachment)
  end
  
  def documents_url
    send "#{resources}_url"
  end

end
