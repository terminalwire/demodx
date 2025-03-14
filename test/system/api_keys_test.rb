require "application_system_test_case"

class ApiKeysTest < ApplicationSystemTestCase
  setup do
    @api_key = api_keys(:one)
  end

  test "visiting the index" do
    visit api_keys_url
    assert_selector "h1", text: "API keys"
  end

  test "should create api key" do
    visit api_keys_url
    click_on "New api key"

    fill_in "Name", with: @api_key.name
    fill_in "Token", with: @api_key.token
    fill_in "User", with: @api_key.user_id
    click_on "Create Api key"

    assert_text "Api key was successfully created"
    click_on "Back"
  end

  test "should update Api key" do
    visit api_key_url(@api_key)
    click_on "Edit this api key", match: :first

    fill_in "Name", with: @api_key.name
    fill_in "Token", with: @api_key.token
    fill_in "User", with: @api_key.user_id
    click_on "Update Api key"

    assert_text "Api key was successfully updated"
    click_on "Back"
  end

  test "should destroy Api key" do
    visit api_key_url(@api_key)
    click_on "Destroy this api key", match: :first

    assert_text "Api key was successfully destroyed"
  end
end
