class UpdateAddress < BaseCommand
  def name
    :update_address
  end

  private
    def update_address
      Address.find(@form.id).update(params)
    end

    def type
      @form.type
    end

    def params
      @form.attributes.without(:type)
    end
end