module Iox
  class PrivilegesMailer < ActionMailer::Base

    # default_from is defined in the config/application.rb file

    def email_invitation( name, email, link )
      @link = link
      @name = name
      puts "NAME: #{name}"
      mail( to: email, subject: "[#{Rails.configuration.iox.site_title}] #{I18n.t('privilege.mailer.subject')}" )
    end

  end
end
