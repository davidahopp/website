require 'spec_helper'

describe DemoController do

  describe "GET 'quicktime'" do
    it "returns http success" do
      get 'quicktime'
      response.should be_success
    end
  end

end
