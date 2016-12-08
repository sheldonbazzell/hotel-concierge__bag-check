class Locker < ActiveRecord::Base
	has_one :guest
	enum size:[:small, :medium, :large]
	def self.which_locker(bag)
		if bag == 0
			locker = Locker.where(size: 0, available: true).first
			if !locker
				bag = 1
			end
		end
		if bag == 1
			locker = Locker.where(size: 1, available: true).first
			if !locker
				bag = 2
			end
		end
		if bag == 2
			locker = Locker.where(size: 2, available: true).first
			if !locker
				id = 0
			end
		end
		if locker
			id = locker.id
			self.update_locker_status(locker)
		end
		id
	end

	def self.update_locker_status(locker)
		locker.update(available: false)
	end

	def self.checkout_guest(id)
		Locker.find(id).update(available:true)
		Guest.where(locker_id:id).first.destroy
	end
end
