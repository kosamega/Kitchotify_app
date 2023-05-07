require "application_system_test_case"

class DaikichisTest < ApplicationSystemTestCase
  setup do
    @daikichi = daikichis(:one)
  end

  test "visiting the index" do
    visit daikichis_url
    assert_selector "h1", text: "Daikichis"
  end

  test "should create daikichi" do
    visit daikichis_url
    click_on "New daikichi"

    fill_in "Counting votes date", with: @daikichi.counting_votes_date
    fill_in "Designer", with: @daikichi.designer_id
    fill_in "Name", with: @daikichi.name
    check "Released" if @daikichi.released
    click_on "Create Daikichi"

    assert_text "Daikichi was successfully created"
    click_on "Back"
  end

  test "should update Daikichi" do
    visit daikichi_url(@daikichi)
    click_on "Edit this daikichi", match: :first

    fill_in "Counting votes date", with: @daikichi.counting_votes_date
    fill_in "Designer", with: @daikichi.designer_id
    fill_in "Name", with: @daikichi.name
    check "Released" if @daikichi.released
    click_on "Update Daikichi"

    assert_text "Daikichi was successfully updated"
    click_on "Back"
  end

  test "should destroy Daikichi" do
    visit daikichi_url(@daikichi)
    click_on "Destroy this daikichi", match: :first

    assert_text "Daikichi was successfully destroyed"
  end
end
