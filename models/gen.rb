class Gen
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  
  has_many :rand_stats  
end