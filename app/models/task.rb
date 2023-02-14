class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: { '未着手': 0, '着手中': 1, '完了': 2 }
  enum priority: { '低': 0, '中': 1, '高': 2 }
  scope :title_search, -> { where("title LIKE ?", "%#{title}%")}
  scope :status_search, -> { where(status :true)}
end
