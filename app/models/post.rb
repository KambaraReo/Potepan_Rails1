class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 20}
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :memo, length: {maximum: 500}
  validate :is_the_date_range_valid?

  def is_the_date_range_valid?
    return unless start_at? && end_at?

    if end_at < start_at
      errors.add(:end_at, "には開始日以降の日付を選択してください。")
    end
  end

end
