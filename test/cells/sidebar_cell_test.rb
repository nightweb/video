require 'test_helper'

class SidebarCellTest < Cell::TestCase
  test "show" do
    html = cell("sidebar").(:show)
    assert html.match /<p>/
  end


end
