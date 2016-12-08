class GuestsController < ApplicationController

	def create
		guest = params[:guest]
		session[:no_vacancy] = false
		if guest[:bag] == 'small'
			number = Locker.which_locker(0)
			guest = Guest.new(name:guest[:name], locker_id:number)
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

		session[:id] = guest.id
		redirect_to '/guests/show'
	end

	def show
		@guest = Guest.joins(:locker).where(id:session[:id]).first
		render '/guests/show'
	end

	def logout
		reset_session
		redirect_to '/lockers/index'
	end
end
