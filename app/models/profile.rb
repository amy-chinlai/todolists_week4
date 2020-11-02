class Profile < ActiveRecord::Base
  belongs_to :user
  
  validate :name_not_null
  validates :gender, inclusion: %w(male female)
  validate :not_sue
  
  def name_not_null
    if first_name.nil? && last_name.nil?
       errors.add(:names, "cannot be blank for both!")
    end
  end 
  
  def not_sue
    if first_name.eql?("Sue") && gender.eql?("male")
      errors.add(:sue, "according to these rules, a male cannot be named Sue but gender is a construct!")
    end
  end
  
  def self.get_all_profiles(min_birth_year, max_birth_year)
    Profile.where("birth_year BETWEEN :min_birth_year AND :max_birth_year", min_birth_year: min_birth_year, max_birth_year: max_birth_year).order(birth_year: :asc)
  end
  
  
end

