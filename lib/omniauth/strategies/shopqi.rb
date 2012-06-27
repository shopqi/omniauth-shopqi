require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Shopqi < OmniAuth::Strategies::OAuth2
      # Available scopes: content themes products customers orders script_tags shipping
      # read_*  or write_*
      DEFAULT_SCOPE = 'read_products'

      option :client_options, {
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }

      option :callback_url

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      def callback_url
        options.callback_url || super
      end

      extra do
        {raw_info: raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get('/api/shop').parsed
      end

    end
  end
end
