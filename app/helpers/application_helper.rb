module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'application/error_messages', :locals =>
        {:object => object})
  end

  def status_tag(boolean, options={})
    options[:true_text] ||=''
    options[:false_text] ||=''

    if boolean
      content_tag(:span, options[:true_text], :class => 'fa fa-check text-success')
    else
      content_tag(:span, options[:false_text], :class => 'fa fa-check text-danger')
    end
  end

  def content_text_by_type(section)
    case section.content_type
      when 'HTML'
        raw(sanitize(section.content, :tags => %w(strong em a)))
      when 'text'
        simple_format(section.content)
      else
        'No content available yet. :('
      end
  end


  def get_clean_text(text)
     truncate(sanitize(text, :tags=>[]), :length => 500)
  end

end
