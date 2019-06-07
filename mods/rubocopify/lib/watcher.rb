class Watcher
  @@mutex = Mutex.new
  @@set = Set.new

  def self.is_ignoring?(key)
    @@set.include?(key)
  end

  def self.ignore(key)
    @@mutex.synchronize do
      @@set.add(key)
    end
  end

  def self.consider(key)
    @@mutex.synchronize do
      @@set.delete(key)
    end
  end
end
