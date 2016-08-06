class Logger
  def initialize
    @file = File.new("logs/#{Time.now.strftime('%Y-%m-%d')}.log", 'a')
  end

  def log(data)
    @file.write("[#{Time.now.strftime('%H:%M:%S')}] #{data}\n")
  end
end
