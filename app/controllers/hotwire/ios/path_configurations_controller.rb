class Hotwire::Ios::PathConfigurationsController < ApplicationController
  def show
    tabs = []
    if current_user
      tabs = [
        {
          title: "Home",
          path: root_path,
          ios_system_image_name: "house"
        },
        {
          title: "Posts",
          path: posts_path,
          ios_system_image_name: "square.and.pencil"
        }
      ]
    end

    render json: {
      settings: {
        tabs: tabs
      },
      rules: [
        {
          patterns: [
            "/new$",
            "/edit$",
            "/users/sign_up",
            "/users/sign_in"
          ],
          properties: {
            context: "modal"
          }
        },
        {
          patterns: ["^/unauthorized"],
          properties: {
            view_controller: "unauthorized"
          }
        },
        {
          patterns: ["^/reset_app$"],
          properties: {
            view_controller: "reset_app"
          }
        }
      ]
    }
  end
end
