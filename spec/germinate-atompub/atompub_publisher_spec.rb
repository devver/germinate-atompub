require File.join(File.dirname(__FILE__), %w[.. spec_helper])

module GerminateAtompub
  describe AtompubPublisher do
    before :each do
      @librarian = stub("Librarian", :make_pipeline => lambda{|x| x})
      @it = AtompubPublisher.new("article", @librarian)
    end

    it "should identify itself as 'atompub'" do 
      AtompubPublisher.identifier.should == "atompub"
    end
  end
end
