class ToolboxController < ApplicationController
  def markdown
    @mdown = params[:mdown]
    @mdown = mdrender(@mdown)
    render json:@mdown
  end
end
