class Category < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def minimum_amount
    super || 0
  end

  def total_expense(month, year)
    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month
    expenses.where(date: start_date..end_date).sum(:amount)
  end

  def last_month_total
    start_date = Date.today.months_ago(1).beginning_of_month
    end_date = Date.today.months_ago(1).end_of_month
    expenses.where(date: start_date..end_date).sum(:amount)
  end

  def last_three_month_average
    start_date = Date.today.months_ago(3).beginning_of_month
    end_date = Date.today.months_ago(1).end_of_month
    expenses.where(date: start_date..end_date).sum(:amount) / 3
  end

  def current_month_total
    start_date = Date.today.beginning_of_month
    end_date = Date.today
    expenses.where(date: start_date..end_date).sum(:amount)
  end
end
