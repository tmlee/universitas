# == Schema Information
# Schema version: 20110227225207
#
# Table name: group_members
#
#  id         :integer(4)      not null, primary key
#  group_id   :integer(4)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class GroupMember < ActiveRecord::Base
  belongs_to :group, :counter_cache => :members_count
  belongs_to :user
	has_many :updates, :as => :target, :dependent => :destroy

	after_create :create_update
  delegate :name, :email, :to => :user

	private
	
	def create_update
		self.user.updates.create!(:target => self) unless self.user.leader_of?(self.group)
	end
end
