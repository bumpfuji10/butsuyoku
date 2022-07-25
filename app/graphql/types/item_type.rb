# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :price, Integer
    field :buy_month, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :reason, String
    field :user_id, Integer
  end
end
