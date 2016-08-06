require 'digest/md5'
class Logger

  def initialize
    @file = File.new("../logs/#{Time.now.strftime('%Y-%m-%d')} - #{Digest::MD5.hexdigest rand.to_s}.log", 'a')
  end

  def log(data)
    @file.write("[#{Time.now.strftime('%H:%M:%S')}] #{data}\n")
  end
end
