require "test_helper"

class SignupTest < ActionDispatch::IntegrationTest
  
  # check if the signup is invalid
  test "invalid signup information" do
    get register_path
    assert_no_difference 'User.count' do
      post register_path,params:{ user:{
        name:"",
        email:"",
        password:"",
        password_confirmation:""
      }}
    end
    assert_template :new
  end

  # check if you signup valid 
  test 'valid signup information' do 
    get register_path
    assert_difference "User.count", 1 do 
      post register_path, params: {
        user: {
          name:"arish villle",
          email:"arish18@gmail.com",
          password: "karlkarlkarl",
          password_confirmation: "karlkarlkarl"
        }
      }
    end
    assert_not flash.empty?
  end

end
