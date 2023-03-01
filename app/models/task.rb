class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: { '未着手': 0, '着手中': 1, '完了': 2 }
  enum priority: { '低': 0, '中': 1, '高': 2 }
  scope :title_search, -> (title) { where("title LIKE ?", "%#{title}%")}
  scope :status_search, -> (status) { where(status: status)}
  scope :label_search, -> (label_ids) { where(id: Labelling.where(label_id: label_ids).pluck(:task_id))}
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end
