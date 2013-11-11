# encoding: utf-8

module Iox
  module HasAccessibleLinks

    extend ActiveSupport::Concern

    module ClassMethods

      def has_accessible_links(options = {})

        include InstanceMethods

      end

    end

    module InstanceMethods

      def gen_access_key
        return unless access_key.blank?
        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
        self.access_key = (0..8).map{ o[rand(o.length)] }.join
        if self.class.where( access_key: access_key ).count > 0
          @gen_access_key_trials ||= 0
          @gen_access_key_trials += 1
          gen_access_key
        end
      end

    end

  end
end

ActiveRecord::Base.send :include, Iox::HasAccessibleLinks