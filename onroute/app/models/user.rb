class User < ActiveRecord::Base
  has_many :participants
  has_many :routes,
    :through => :participants,
    :source => :route
      attr_accessible :email, :password, :password_confirmation, :country, :surname, :name, :gender

      attr_accessor :password
      before_save :encrypt_password

      validates_confirmation_of :password
      validates_presence_of :password, :on => :create
      validates_presence_of :email
      validates_uniqueness_of :email
      validates :name, :presence => true, :length => {:maximum => 30}
      validates :surname, :presence => true, :length => {:maximum => 30}
      validates :country, :presence => true,:length => {:maximum => 30}
      validates :gender, :presence => true,:length => {:maximum => 10}

      def self.authenticate(email, password)  # Autenticamos al usuario.
        user = find_by_email(email) # Lo buscamos por el email.
        if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) # Si coincide el usuario y la contraseña..
          user  # Devuelve usuario.
        else
          nil   # Devuelve nil.
        end
      end

      def encrypt_password  # Escriptamos la password.
        if password.present?  # Existe la password?
          self.password_salt = BCrypt::Engine.generate_salt # Primer elemento generado por el engine.
          self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  # Segundo elemento generado por el engine.
        end
      end
    
end
