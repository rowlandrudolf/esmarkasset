class DocumentsController < ApplicationController
  
  before_action :validate_type!

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
  	if @doument.update(document_params)
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

  def validate_type!
    unless Document.types.include?(params[:type])
      redirect_to root_url, notice: 'Invald document request'
    end
  end
  
  def document_params
    params(klass_name.to_sym).permit(:title,:author,:date,:description,:attachemnt)
  end

  def klass
  	params[:type].constantize
  end
  
  def klass_name
    params[:type].downcase
  end

  def documents_url
    send "{klass_name.pluralize}_url"
  end

end
