class Ability < ActiveRecord::Base
  attr_accessible :job_id, :jp, :kind, :mp, :name, :speed
  belongs_to :job
end
