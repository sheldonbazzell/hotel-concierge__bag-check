class LockersController < ApplicationController
	def index
		@guests = Guest.all
	end

	def update
		Locker.checkout_guest(params[:id])
		redirect_to '/lockers/index'
	end
end
