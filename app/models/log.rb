class Log < ApplicationRecord
  belongs_to :dog
  validates :medication, inclusion: { in: %w[None Antibiotic Antiparasitic Antifungal Steroids Pain Relief] }
  validates :food, inclusion: { in: %w[Kibble Canned Raw Home-made] }
  validates :grooming, inclusion: { in: %w[Bath Brush Nail-trim Ear-care Fur-cut Brush-teeth] }
  validates :special_treat, inclusion: { in: %w[Crunchy Soft Jerky Dental-chews Animal-based Rawhide Home-made] }
  validates :stool, inclusion: { in: %w[Normal Constipation Diarrhea] }
  validates :vaccination, inclusion: { in: %w[None Distemper Parvovirus Adenovirus Leptospira] }
  validates :mood, inclusion: { in: %w[Happy Fearful Anxious Jealous Aggressive] }
  validates :energy, inclusion: { in: %w[Energertic Ok Tired Exhausted Calm Excited] }
  validates :training, inclusion: { in: %w[Obedience Therapy Behavioural Agility Protection Service Tracking] }

  MEDICATION = ["None", "Antibiotic", "Antiparasitic", "Antifungal", "Steroids", "Pain", "Relief"]
  FOOD = ["Kibble", "Canned", "Raw", "Home-made"]
  GROOMING = ["Bath", "Brush", "Nail-trim", "Ear-care", "Fur-cut", "Brush-teeth"]
  SPECIAL_TREAT = ["Crunchy", "Soft", "Jerky", "Dental-chews", "Animal-based", "Rawhide", "Home-made"]
  STOOL = ["Normal", "Constipation", "Diarrhea"]
  VACCINATION = ["None", "Distemper", "Parvovirus", "Adenovirus", "Leptospira"]
  MOOD = ["Happy", "Fearful", "Anxious", "Jealous", "Aggressive"]
  ENERGY = ["Energertic", "Ok", "Tired", "Exhausted", "Calm Excited"]
  TRAINING = ["Obedience", "Therapy", "Behavioural", "Agility", "Protection", "Service", "Tracking"]
end
