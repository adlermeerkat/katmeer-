#This is our spec for the STATIC_PAGES CONTROLLER

require 'spec_helper'

describe StaticPagesController do
	subject {page}

	describe "Home" do

		before {visit root_path}

		it {page.should have_selector('title', text: full_title('Home'))}
	end
end