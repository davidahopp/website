class MyJstProcessor < Sprockets::JstProcessor
  def prepare
    @namespace = 'this.website.templates'
  end
end
Website::Application.assets.register_engine('.jst', MyJstProcessor)