class LockersController < ApplicationController
	def index
		@guests = Guest.all
	end

	# update method calls checkout_guest, passing in respective guest's locker id
	def update
		Locker.checkout_guest(params[:id])
		redirect_to '/lockers/index'
	end
end
