# encoding: utf-8

module Iox
  module HasAccessibleLinks

    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def has_accessible_links(options = {})

        include InstanceMethods
        has_many :privileges

      end

    end

    module InstanceMethods

      def gen_public_key
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        self.public_key = (0..8).map{ o[rand(o.length)] }.join
        if self.class.where( public_key: public_key ).count > 0
          @gen_public_key_trials ||= 0
          @gen_public_key_trials += 1
          gen_public_key
        end
      end

    end

  end
end

ActiveRecord::Base.send :include, Iox::ActsAsCloudContainer