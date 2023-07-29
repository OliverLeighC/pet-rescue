# == Schema Information
#
# Table name: adoptions
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  adopter_account_id :bigint           not null
#  pet_id             :bigint           not null
#
# Indexes
#
#  index_adoptions_on_adopter_account_id  (adopter_account_id)
#  index_adoptions_on_pet_id              (pet_id)
#
# Foreign Keys
#
#  fk_rails_...  (adopter_account_id => adopter_accounts.id)
#  fk_rails_...  (pet_id => pets.id)
#
class Adoption < ApplicationRecord
  belongs_to :pet
  belongs_to :adopter_account

  after_create_commit :send_checklist_reminder

  def send_checklist_reminder
    MatchMailer.checklist_reminder(self).deliver_later
  end
end
