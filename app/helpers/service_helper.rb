module ServiceHelper
  
  #替换随机表达式里的字符串，并用随机数代替
  def expressProcess(str)
    str.gsub(/\$random\((\w+)\)/) do |gs|
      genRandom("#$1")
    end
    
  end
  
  #根据传入字符串生成随机数
  #生成的字符串与原字符串长度相同，格式相同；
  #例如92dgeg33 生成的可能是24gihb20 
  #注意:每位是对应的 数字是数字，字母也是字母
  def genRandom(str)
    str.gsub(/./) do |s|
      if(/\d/.match(s))
        rand(9)
      else
        chars = ("a".."z").to_a + ("A".."Z").to_a
        chars[rand(chars.size-1)]
      end
    end
  end
end
