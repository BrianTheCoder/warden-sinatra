class User < CouchRest::ExtendedDocument   
  include CouchRest::Validation
  include Extlib::Hook

  use_database CouchRest.database!('obc')

  attr_accessor :password, :password_confirmation
    
  view_by :handle
  view_by :email
  
  property :email
  property :crypted_password
  property :name
  property :birthdate
  property :handle
  property :region
  property :interests
  property :company_description
  
  timestamps!
  validates_present :email, :handle
  validates_present :password, :password_confirmation, :if => proc{|m| m.password_required?}
  validates_is_confirmed :password, :if => proc{|m| m.password_required?}
    
  before :save do
    errors.add(:handle, "Handle already registered") if User.by_handle(:key => self.handle)
  end

  before :save, :password_checks
  
  def password_checks
    if password_required?
      return false unless !password.blank? && password == password_confirmation
    end
    encrypt_password
    true
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  def encrypt_password
    self.crypted_password = BCrypt::Password.create("my password")
  end
  
  def authenticated?(password)
    BCrypt::Password.new(crypted_password) == password
  end
  
  def encrypt_password
    return if password.blank?
    self.crypted_password = BCrypt::Password.create(password)
  end

  def self.authenticate(login, password)
    @u = self.by_email(:key => login).first
    @u && @u.authenticated?(password) ? @u : nil
  end 
  
end