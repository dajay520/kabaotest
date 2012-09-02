class ConditionParams < ActiveRecord::Base
  attr_accessible :in, :name, :out, :remark
  belongs_to :interface
end
