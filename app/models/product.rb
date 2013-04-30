class Product < ActiveRecord::Base
  attr_accessible :image, :description, :name, :price, :quality, :user_id, :tag
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  mount_uploader :image, ImageUploader
  validates_presence_of :name, :price, :quality, :image
  validates :name, :length => {:minimum => 3}
  validates :name, :uniqueness => true
  validates :price, :numericality => {:greater_than => 0}


  #for searching
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.searchtag(search)
    if search
      where('tag LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
