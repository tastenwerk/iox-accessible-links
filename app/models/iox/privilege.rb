module Iox
  class Privilege < ActiveRecord::Base
    belongs_to :accessible, polymorphic: true
    has_accessible_links
  end
end
