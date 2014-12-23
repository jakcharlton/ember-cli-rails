module FrontEnd
  extend ActiveSupport::Concern

  private

  def index_html namespace=nil
    @namespace = namespace

    index_key = if @namespace
                  "#{@namespace}:#{deploy_key}:app.html"
                else
                  "#{deploy_key}:app.html"
                end

    $redis.get index_key
  end

  def deploy_key
    if params[:deploy].nil?
      current_deploy
    elsif params[:deploy] == 'canary'
      latest_deploy
    else
      params[:deploy]
    end
  end

  def latest_deploy
    manifest_key = @namespace ? "#{@namespace}:latest_ten_deploys" : 'latest_ten_deploys'

    $redis.lindex manifest_key, 0
  end

  def current_deploy
    return latest_deploy unless Rails.env.production?
    deploy = @namespace ? frontend_deploy[@namespace] : frontend_deploy[:main]
    deploy == 'latest' ? latest_deploy : deploy
  end

  def frontend_deploy
    frontend_deploy = YAML.load File.read Rails.root.join('config/frontend_deploy.yml')
    frontend_deploy.with_indifferent_access[:deploy]
  end
end