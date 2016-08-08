class CreateAddress < BaseCommand
  def name
    :create_address
  end

  private
    def create_address
      current_user.update(type => Address.create(params))
    end

    def type
      @form.type
    end

    def params
      @form.attributes.without(:type)
    end
end
