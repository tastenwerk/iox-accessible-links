# extends webpage with privileges

require_dependency "iox/application_controller"

module Iox
  class WebpagePrivilegesController < ApplicationController

    def create
      if @webpage = Iox::Webpage.find_by_id( params[:webpage_id] )
        if priv = @webpage.privileges.where(email: params[:privilege][:email]).first
          PrivilegesMailer.email_invitation( params[:privilege][:name], params[:privilege][:email], get_full_key(priv) ).deliver
          flash.notice = I18n.t('privilege.email_sent_again')
        else
          priv = @webpage.privileges.build webpage_privilege_params
          priv.gen_access_key
          priv.expires_at = @webpage.access_expires
          if priv.save
            flash.notice = I18n.t('privilege.confirm_next')
            PrivilegesMailer.email_invitation( params[:privilege][:name], params[:privilege][:email], get_full_key( priv ) ).deliver
          else
            flash.alert = I18n.t('privilege.email_failed')
          end
        end
      else
        flash.alert = I18n.t('webpage.not_found')
      end
      render json: { flash: flash }
    end

    def index
      if @webpage = Iox::Webpage.find_by_id( params[:webpage_id] )
        render json: @webpage.privileges
      else
        render json: { error: 'failed to load privileges' }, status: 500
      end
    end

    def csv
      if @webpage = Iox::Webpage.find_by_id( params[:webpage_id] )
        res = "pos,email address\n"
        @webpage.privileges.each_with_index do |priv,index|
          res << index.to_s << "," << priv.email << "\n"
        end
        render text: res, content_type: 'text/csv'
      end
    end

    private

    def webpage_privilege_params
      params.require(:privilege).permit( :name, :organization, :phone, :email )
    end

    def get_full_key( priv )
      url = "#{url_for(@webpage)}?k=#{Base64.encode64("#{@webpage.id},#{priv.access_key},#{priv.email}")}"
      puts "Key URL: #{url}"
      url
    end

  end
end