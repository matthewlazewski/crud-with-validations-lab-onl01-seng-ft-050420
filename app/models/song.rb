class Song < ApplicationRecord
    validates :title, :artist_name, :genre, presence: true
    validate :unique_title
    validates :release_year, presence: true, 
        if: :released?
    validate :invalid_date
    

    def unique_title
        if Song.any? {|s| s.title == title && s.artist_name == artist_name && s.release_year == release_year}
            errors.add(:title, "cannot have same song twice")
        end 
    end 

    def invalid_date
        if release_year.present? && release_year > Date.today.year 
            errors.add(:release_year, "date is not valid")
        end 
    end 
end
