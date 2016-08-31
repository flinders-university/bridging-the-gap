module ApplicationHelper

  # Generates menu items for @pages...
  def generate_menu_pages
    @pages ||= Page.where(public: true)
    @pmenu = ""
    @pages.each do |page|
       @pmenu = @pmenu + "\n <li><a href=\"/pages/#{page.slug}\">#{page.title}</a></li>"
    end
    return @pmenu
  end

  # metadata, titles, etc
  def title(text)
    content_for :title, text
  end

  def yield_controller
    controller_name.gsub("_", " ").capitalize + " | "
  end

  def meta_tag(tag, text)
      content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
      content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def admin_pages
    if current_user_administrator?
      admin_pages = ["group_change_requests", "groups", "i_surveys", "i_questions", "answers", "usertools", "realtime", "contact_database", "forms", "documents", "industries"]
    else
      admin_pages = []
    end
  end

  def humanise_boolean(boolean)
    if boolean == true
      "Yes"
    else
      "No"
    end
  end

end
