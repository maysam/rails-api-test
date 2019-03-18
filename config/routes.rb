# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :users, except: %i[new edit]
  end
end
