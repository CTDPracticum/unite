class Membership < ApplicationRecord
    belongs_to :user
    belongs_to :group
    
    #one user membership per group
    validates :user_id, uniqueness: { scope: :group_id} 
end
