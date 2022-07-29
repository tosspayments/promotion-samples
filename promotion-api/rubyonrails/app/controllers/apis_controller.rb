class PaymentController < ApplicationController

  def promotion
    options = {
      headers: {
        Authorization: "Basic " + Base64.strict_encode64("test_sk_D4yKeq5bgrpKRd0JYbLVGX0lzW6Y:"),
        "Content-Type": "application/json"
      }
    }
      
	begin
      response = HTTParty.get("https://api.tosspayments.com/v1/promotions/card", options).parsed_response
      @Response = response
    end
      
  end
  
end