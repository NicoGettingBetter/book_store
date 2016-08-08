module AddressHelper
  def countries
    Country.all.collect{ |c| [c.name, c.id] }
  end
end