require 'test_helper'

class SectionsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sections_controller_index_url
    assert_response :success
  end

  test "should get show" do
    get sections_controller_show_url
    assert_response :success
  end

  test "should get new" do
    get sections_controller_new_url
    assert_response :success
  end

  test "should get edit" do
    get sections_controller_edit_url
    assert_response :success
  end

  test "should get delete" do
    get sections_controller_delete_url
    assert_response :success
  end

end
