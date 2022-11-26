class JsonWebToken
    ALGO = 'RS256'
    JWT_SECRET = ENV["JWT_SECRET"]
    def self.encode(payload)
      expiration = 2.weeks.from_now.to_i
      JWT.encode payload.merge(exp: expiration), Rails.application.secret_key_base
    end
   
    def self.decode(token)
      JWT.decode(token, Rails.application.secret_key_base).first
    end

    def self.encode_data(payload, exp = 2.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, private_key, ALGO)
    end

    def self.decode_data(token)
      body = JWT.decode(token, private_key.public_key, true, algorithm: ALGO)[0]
      HashWithIndifferentAccess.new body
      # rescue from expiry exception
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      # raise custom error to be handled by custom handler
      raise ExceptionHandler::ExpiredSignature, e.message
    end

    private

      def private_key
        @rsa_private ||= OpenSSL::PKey::RSA.generate 2048
      end
end 