require 'spec_helper'

describe Wine do
  
  it "should not be valid for a blank model" do
    wine = Wine.new
    expect(wine).to_not be_valid
    expect(wine.errors[:name][0]).to eq("can't be blank")
  end
  
  it "should reject duplicate lcbo number" do
    wine1 = Wine.new(:lcbo => '12345', :name => "Chateau de Test 1")
    wine1.save
    wine2 = Wine.new(:lcbo => '12345', :name => "Chateau de Test 2")
    expect(wine2).to_not be_valid
    expect(wine2.errors[:lcbo][0]).to eq("has already been taken")
  end
  
end
