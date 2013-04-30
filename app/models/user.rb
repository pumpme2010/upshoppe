class User < ActiveRecord::Base
  attr_accessible :image, :email, :password, :password_confirmation, :contact_number, :description, :address, :admin, :shopname
  attr_accessor :password
  before_save :encrypt_password
  has_many :products, :dependent => :destroy, :uniq => true
  has_many :messages
  mount_uploader :image, ImageUploader

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :shopname
  validates_uniqueness_of :email
  #validate regex for mail
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, :length => {:minimum => 5}, :on => :create
  validates_numericality_of :contact_number

  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end

  def self.authenticate(email, password)
  	user = find_by_email(email)
  	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  		user
  	else
  		nil
  	end
  end

  def self.search(search)
    if search
      where('shopname LIKE ?', "%#{search}%") 
    else
      scoped
    end
  end
end
