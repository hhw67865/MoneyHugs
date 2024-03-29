class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :minimum_amount, :color
  has_many :expenses do
    object.expenses.order(date: :desc)
  end

  attribute :last_month_total, key: :last_month_total
  attribute :last_three_month_average, key: :last_three_month_average
  attribute :current_month_total, key: :current_month_total
end
