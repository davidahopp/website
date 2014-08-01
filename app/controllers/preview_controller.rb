class PreviewController < ApplicationController

  before_filter :set_layout

  def index

  end

  private

  def set_layout
    render layout: 'preview'
  end
  
end
