# coding: utf-8
require "csv"

Ability.delete_all
CSV.foreach('db/seeds_data/whitemage.csv') do |row|
  Ability.create(:job_id => row[0], :kind => row[1], :name => row[2], :mp => row[3], :speed => row[4], :jp => row[5])
end
