require_dependency "iox/application_controller"

module Iox
  class PrivilegesController < ApplicationController

    def destroy
      success = false
      if @privilege = Privilege.find_by_id( params[:id] )
        if @privilege.destroy
          flash.now.notice = t('deleted')
          success = true
          flash.now.notice = t('subscriber.deleted', name: @privilege.name)
        else
          flash.now.alert = t('deletion_failed')
        end
      else
        flash.now.alert = t('not_found')
      end
      render json: { flash: flash, success: success, item: @privilege }
    end

  end
end