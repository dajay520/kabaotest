#encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Interface.create(
  [
    {
      name_cn:'我的优惠券list接口',
      name_en:'mycouponlist'
    },
    {
      name_cn:'优惠券detail（详情）接口',
      name_en:'ecoupondetail'
    },
    {
      name_cn:'可核销门店list接口',
      name_en:'localstorelist'
    },
    {
      name_cn:'核销list接口',
      name_en:'verifiedlist'
    },
    {
      name_cn:'城市定位接口',
      name_en:'gpslocation'
    },
    {
      name_cn:'品牌list接口',
      name_en:'brandlist'
    },
    {
      name_cn:'类目list接口',
      name_en:'categorylist'
    },
    {
      name_cn:'优惠券list（市场）接口',
      name_en:'ecouponlist'
    },
    {
      name_cn:'是否绑定淘宝账户接口',
      name_en:'istaobaobinded'
    }
  ]
)
