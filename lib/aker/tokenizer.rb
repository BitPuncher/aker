module Aker
  class Tokenizer
    attr_reader :errors

    def initialize(headers: {}, payload: {}, token: nil)
      @headers = {"typ" => "JWT"}.merge(headers)
      @payload = payload
      @payload['exp'] ||= 2.minutes.from_now.to_i
      @payload['iss'] = config[:issuer] if config[:issuer]
      @token = token
      @errors = {}
    end

    def encode
      return token if encoded?
      headers['alg'] = 'HS256' unless config[:allowed_algorithms].include?(headers['alg'])
      key = key_for_algorithm(:encode, headers['alg'])
      begin
        @token = JWT.encode(payload, key, headers['alg'])
      rescue TypeError => e
        errors[:encryption_key] = "has not been configured for given algorithm."; nil
      end
    end

    def encoded?
      token.present?
    end

    def decode
      return [payload, headers] if decoded?
      begin
        payload, headers = JWT.decode(token) {|headers| key_for_algorithm(:decode, headers['alg'])}
      rescue JWT::VerificationError, JWT::IncorrectAlgorithm
        errors[:token] = "cannot be validated."; nil
      rescue JWT::ExpiredSignature
        errors[:expiration] = "cannot be in the past."; nil
      end
    end

    def decoded?
      payload.present? && headers.present?
    end

    def authentic?
      decoded? && errors.empty?
    end

    private

    attr_accessor :headers, :payload, :token

    def config
      Aker.configuration || {}
    end

    def key_for_algorithm(direction, algo)
      {
        encode: {'HS256' => config[:hmac_secret],
                 'RS256' => OpenSSL::PKey::RSA.new(config[:rsa_private])},
        decode: {'HS256' => config[:hmac_secret],
                 'RS256' => OpenSSL::PKey::RSA.new(config[:rsa_public])}
      }[direction][algo]
    end
  end
end
