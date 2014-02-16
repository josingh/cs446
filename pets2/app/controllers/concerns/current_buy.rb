module CurrentCheckout
	extend ActiveSupport::Concern
	private

		def set_checkout
			@checkout = Checkout.find(session[:checkout_id])
		rescue ActiveRecord::RecordNotFound
			@checkout = Checkout.create
			session[:checkout_id] = @checkout.id
		end
end