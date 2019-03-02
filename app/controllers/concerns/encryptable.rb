module Encryptable
  extend ActiveSupport::Concern

  #----------------------------------
  # Encrypt Text Data
  # args     : string
  # returns  : string
  # Reference: https://api.rubyonrails.org/v5.2.2/classes/ActiveSupport/MessageEncryptor.html
  #----------------------------------
  def encrypt(text)
    len   = ActiveSupport::MessageEncryptor.key_len
    salt  = SecureRandom.random_bytes(len)
    key   = ActiveSupport::KeyGenerator.new(Rails.application.credentials.secret_key_base).generate_key(salt, len) # Secret Key Base is in Rails.application.secrets.secret_key_base
    crypt = ActiveSupport::MessageEncryptor.new(key)
    encrypted_data = crypt.encrypt_and_sign(text)
    # If you need decrypt -> crypt.decrypt_and_verify(encrypted_data)
  end
end
