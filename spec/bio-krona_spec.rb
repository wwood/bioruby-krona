require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "BioKrona" do
  it "should collapse hashes right" do
    big = {%w(a b c)=>2, %w(a b f)=>4, %w(g)=>5}
    
    expected = {%w(a)=>6, %w(g)=>5}
    Bio::Krona.collapse(big, 1).should eq(expected)
    
    expected = {%w(a b)=>6, %w(g)=>5}
    Bio::Krona.collapse(big, 2).should eq(expected)
    
    Bio::Krona.collapse(big, 3).should eq(big)
    Bio::Krona.collapse(big, 4).should eq(big)
  end
end
