# encoding: utf-8
class Interface < ActiveRecord::Base
  attr_accessible :name_cn, :name_en, :remark, :type, :selected
  has_many :condition_paramss
  validates_format_of :name_en, :with => /^\w+$/,  :message => "接口名称必须是字母"
  validates_presence_of :name_cn, :message => "中文名称不能为空"
  validates_uniqueness_of :name_en, :message => "英文名称已存在"
end
