class WelcomeController < ApplicationController
  def index
  end

  def news
    @concerts = Concert.active
  end

  def video
    @videos = (Youtube.new).All
  end

  def contact
  end
end
