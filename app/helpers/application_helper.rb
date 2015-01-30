module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

end
