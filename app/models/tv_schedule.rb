class TvSchedule < ApplicationRecord
  validates :keyword, presence: { message: 'は１文字以上入力してください。' }
end
