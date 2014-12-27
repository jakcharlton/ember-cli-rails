# Handles specific changes to make to the HTML for Ember
module HtmlHandler
  extend ActiveSupport::Concern

  private

  def insert_flags(*flags)
    return if flags.empty?
    concat_flags = flags.map { |flag| send flag.concat('_flag') }.join ','
    flag_tags = "<script>window.ENV = {#{ concat_flags }};</script>"

    @index_html.insert head_tag_position, flag_tags
  end

  def head_tag_position
    @pos ||= @index_html.index('>', @index_html.index('<head')) + 1
  end

  def features_flag
    'SHOW_PONY: false'
  end

  def ab_test_flag
    ab = %w([A B]).sample
    "AB: '#{ab}'"
  end

  def deploy_key_flag
    "DEPLOY: #{deploy_key}"
  end
end
