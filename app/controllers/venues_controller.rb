class VenuesController < ApplicationController

	private

	# Never trust parameters from the scary internet, only allow the white list through.
	def venue_params
	  params.require(:venue).permit(:address, :country, :county, :lat, :lng, :title)
	end
end
