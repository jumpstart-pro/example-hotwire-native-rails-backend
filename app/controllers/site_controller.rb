class SiteController < ApplicationController
  def show
    @readme = renderer.render(File.read(file))
  end

  def reset_app
    # Hotwire Native needs an empty page to route authentication and reset the app.
    # We can't head: 200 because we also need the Turbo JavaScript in <head>.
  end

  private

  def renderer
    Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def file
    Rails.root.join("README.md")
  end
end
