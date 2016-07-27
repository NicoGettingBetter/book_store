class UpdateReview < BaseCommand
  def name
    :update_review
  end

  private
    def update_review
      Review.find(@form.id).update(@form.attributes)
    end
end