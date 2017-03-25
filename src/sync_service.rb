require_relative 'parser'

class SyncService
  def initialize(file_name)
    @parser = Parser.new(file_name)
  end

  def sync
    sync_floors
    sync_apartments
    sync_residents
  end

  def sync_floors
    @parser.floors.each { |floor| floor.sync }
  end

  def sync_apartments
    @parser.apartments.each { |apartment| apartment.sync }
  end

  def sync_residents
    @parser.residents.each { |resident| resident.sync }
  end
end
