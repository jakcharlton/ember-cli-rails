class ApplicationController < ActionController::Base
  include FrontEnd
  include HtmlHandler

  def index
    @index_html = index_html
    insert_flags 'deploy_key', 'ab_test', 'features'

    render text: @index_html
  end

end