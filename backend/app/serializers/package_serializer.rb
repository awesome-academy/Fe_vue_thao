# frozen_string_literal: true

class PackageSerializer < ActiveModel::Serializer
  attributes :package_id, :name, :price, :duration_days, :features, :is_active,
             :created_at, :updated_at
end
