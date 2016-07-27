class BaseCommand < Rectify::Command 
  def initialize form
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?

    transaction do
      send(name)
    end

    broadcast(:ok)
  end

  def name
    raise NoMethodError 'You must define name method for sub class.'
  end
end