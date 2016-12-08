class GuestsController < ApplicationController

	def create
		# Receive name & bag size from form
		guest = params[:guest]
		session[:no_vacancy] = false
		# Call Locker.which_locker based on corresponding bag size
		if guest[:bag] == 'small'
			# Locker.which_locker returns a locker id
			number = Locker.which_locker(0)
			# Guest is established
			guest = Guest.new(name:guest[:name], locker_id:number)
			# If lockers were full, Locker.which_locker returns 0
			if number == 0
				session[:no_vacancy] = true
			else
				guest.save!
			end
		elsif guest[:bag] == 'medium'
			number = Locker.which_locker(1)
			guest = Guest.new(name:guest[:name], locker_id:number)
			if number == 0
				session[:no_vacancy] = true
			else
				guest.save!
			end
		elsif guest[:bag] == 'large'
			number = Locker.which_locker(2)
			guest = Guest.new(name:guest[:name], locker_id:number)
			if number  == 0
				session[:no_vacancy] = true
			else
				guest.save!
			end
		end
		# Guest id is stored in session so name & locker id can be printed on receipt (show.html.erb)
		session[:id] = guest.id
		redirect_to '/guests/show'
	end

	def show
		@guest = Guest.joins(:locker).where(id:session[:id]).first
		render '/guests/show'
	end

	# After printing guest's receipt, concierge returns to home page, and session is cleared
	def home
		reset_session
		redirect_to '/lockers/index'
	end
end
