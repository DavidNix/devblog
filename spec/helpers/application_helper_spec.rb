require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do

    brand = DevblogExtensions::WEBSITE_NAME

    it "includes the page name" do
      full_title("foo").should eq("#{brand} | foo")
    end

    it "includes the base name" do
      full_title("foo").should =~ /^#{brand}/
    end

    it "has only brand name for passing empty string" do
      full_title("").should eq(brand)
    end

    it "has only brand name for passing nil" do
      full_title.should eq(brand)
    end

    it "does not include the base name" do
      full_title("Test Title", true).should eq("Test Title")
    end

  end
end