class PagesController < ApplicationController
  include FrontEnd
  include HtmlHandler

  def index
    if Rails.env.development?
     @index_html =  File.read Rails.root.join('public','app.html')
    else
      @index_html = index_html
    end
    insert_flags 'deploy_key', 'ab_test', 'features'
    render text: @index_html
  end
end