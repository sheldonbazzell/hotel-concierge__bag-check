class Locker < ActiveRecord::Base
	has_one :guest
	enum size:[:small, :medium, :large]

	# generate appropriate locker, given guest's bag size
	def self.which_locker(bag)
		if bag == 0
			locker = Locker.where(size: 0, available: true).first
			# if locker object isn't found, assign guest locker of size 'medium'
			if !locker
				bag = 1
			end
		end
		if bag == 1
			locker = Locker.where(size: 1, available: true).first
			# if locker object isn't found, assign guest locker of size 'large'
			if !locker
				bag = 2
			end
		end
		if bag == 2
			locker = Locker.where(size: 2, available: true).first
			# if locker object isn't found, hotel won't be able to accomodate this guest currently
			if !locker
				id = 0
			end
		end
		# locker was successfully pulled for guest, updating availability to false in database
		# => and generating function's return value (id)
		if locker
			id = locker.id
			self.update_locker_status(locker)
		end
		id
	end

	def self.update_locker_status(locker)
		locker.update(available: false)
	end

	# when concierge checks out guest, update availability of locker to true
	# => and remove guest from database
	def self.checkout_guest(id)
		Locker.find(id).update(available:true)
		Guest.where(locker_id:id).first.destroy
	end
end
