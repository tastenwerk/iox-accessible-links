module Iox
  class Privilege < ActiveRecord::Base
    belongs_to :accessible, polymorphic: true
  end
end
