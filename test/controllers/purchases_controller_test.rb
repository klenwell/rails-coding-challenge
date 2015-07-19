require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  test "should display index page with upload form" do
    get :index
    assert_response :success
    assert_select 'input#upload'
  end

  test "should display error message when no file submitted" do
    post :upload
    assert_response :redirect
    assert_equal 'Please submit a file.', flash[:alert]
  end

  test "should save data when valid tab file uploaded and display total revenue" do
    assert_difference('Purchase.count', +4) do
      post :upload, upload: fixture_file_upload('files/valid_data.tab')
    end

    assert_response :success
    assert_select 'h4.upload_success'
    assert_select 'span.total_revenue', {text: '$95.00'}

    # Verify associated data created.
  end

  test "should not save data when file with invalid data uploaded" do
  end
end
