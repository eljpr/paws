class Log < ApplicationRecord
  belongs_to :dog
  validates :medication, inclusion: { in: %w[`none antibiotic antiparasitic antifungal steroids pain relief`] }
  validates :food, inclusion: { in: %w[`kibble canned raw home-made`] }
  validates :grooming, inclusion: { in: %w[`bath brush nail-trim ear-care fur-cut brush-teeth`]}
  validates :special_treat, inclusion: { in: %w[`crunchy soft jerky dental-chews animal-based rawhide home-made`] }
  validates :stool, inclusion: { in: %w[`normal constipation diarrhea`]}
  validates :vaccination, inclusion: { in: %w[`none distemper parvovirus adenovirus leptospira)`] }
  validates :mood, inclusion: { in: %w[`happy fearful anxious jealous aggressive`] }
  validates :energy, inclusion: { in: %w[`energertic ok tired exhausted calm excited`] }
  validates :training, inclusion: { in: %w[`obedience therapy behavioural agility protection service tracking`] }
end
