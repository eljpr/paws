class Log < ApplicationRecord
  MEDICATION    = ["None", "Antibiotic", "Antiparasitic", "Antifungal", "Steroids", "Pain", "Relief"]
  FOOD          = ["Kibble", "Canned", "Raw", "Home-made"]
  GROOMING      = ["Bath", "Brush", "Nail-trim", "Ear-care", "Fur-cut", "Brush-teeth"]
  SPECIAL_TREAT = ["Crunchy", "Soft", "Jerky", "Dental-chews", "Animal-based", "Rawhide", "Home-made"]
  STOOL         = ["Normal", "Constipation", "Diarrhea"]
  VACCINATION   = ["None", "Distemper", "Parvovirus", "Adenovirus", "Leptospira"]
  MOOD          = ["Happy", "Fearful", "Anxious", "Jealous", "Aggressive"]
  ENERGY        = ["Energertic", "Ok", "Tired", "Exhausted", "Calm", "Excited"]
  TRAINING      = ["Obedience", "Therapy", "Behavioural", "Agility", "Protection", "Service", "Tracking"]

  belongs_to :dog
end
