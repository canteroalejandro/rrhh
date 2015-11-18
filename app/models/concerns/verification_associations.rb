module VerificationAssociations
  extend ActiveSupport::Concern

  included do
    before_destroy :check_associations
  end

  def check_associations
    errors.clear
    self.class.reflect_on_all_associations(:has_many).each do |association|
      if send(association.name).any?
        errors.add :base, :delete_association,
          model:            self.class.model_name.human.capitalize,
          association_name: self.class.human_attribute_name(association.name).downcase
      end
    end

    return false if errors.any?
  end

end