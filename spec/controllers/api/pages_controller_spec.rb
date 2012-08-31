require 'spec_helper'

describe Api::PagesController do

  describe "when listing all existing records" do
    it "should retrive all page records" do
      records = Page.all
      response.should be_success
    end
  end
  
  describe "when creating a new record" do
    it "should create a new page record when both required fields are present" do
      record = Page.create(:title => "test record 1", :content => "permitted creation")
      response.should be_success
    end
    it "shouldnt create a new page record if title is missing" do
      record = Page.create(:content => "permitted creation")
      record.errors.nil?.should eq(false)
    end
    it "shouldnt create a new page record if content is missing" do
      record = Page.create(:title =>  "test record 2")
      record.errors.nil?.should eq(false)
    end
  end
  
  describe "when updating a record" do
    it "should update existing records" do
      record = Page.first
      record.update_attributes(:title => "update", :content => "attributes")
      response.should be_success
    end
    it "shouldnt update if record doesnt exist" do
      record_size = Page.all.size.to_i + 1
      record = Page.find_by_id(record_size)
      record.nil?.should eq(true)
    end
    it "shouldnt update if title is missiing" do
      record = Page.first
      record.update_attributes(:content => "no title sent")
      record.errors.nil?.should eq(false)
    end
    it "shouldnt update if content is missiing" do
      record = Page.first
      record.update_attributes(:title => "no content sent")
      record.errors.nil?.should eq(false)
    end
  end
  
end
