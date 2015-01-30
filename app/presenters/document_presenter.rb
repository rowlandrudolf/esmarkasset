class DocumentPresenter < BasePresenter
 
  presents :document

  def heading
    t.content_tag :h2, document.title
  end

  def subheading
  	return unless document.author.present? || document.date.present?
    t.content_tag :h4 do 
      if document.author.present? && document.date.present?
        [document.author, t.l(document.date)].join( ' - ' )
      elsif document.date.present? 
        t.l(document.date)
      else
        document.author 
      end
    end
  end

  def description
   t.content_tag :p, document.description if document.description.present?
  end

  def attachment
   t.link_to 'View', document.attachment.url if document.attachment.present? 
  end

  def link_to_edit
   t.link_to 'Edit', "#{document.model_name.collection}/#{document.id}/edit"
  end

  def link_to_destroy
   t.link_to 'Destroy', "#{document.model_name.collection}/#{document.id}", method: :delete, data: { confirm: 'Are you Sure?' }
  end

end