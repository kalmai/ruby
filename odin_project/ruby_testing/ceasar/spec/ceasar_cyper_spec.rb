require '../ceasar_cypher'

describe Cypher do 
  describe "#ceasar_cipher" do
    it "returns 'e' when 'c' is entered by moving the character up 2 characters" do
      cypher = Cypher.new
      expect(cypher.caesar_cipher('c',2)).to eql('e')
    end

    it "returns 'a' when 'z' is moved up by 1 by method" do
      cypher = Cypher.new
      expect(cypher.caesar_cipher('z',1)).to eql('a')
    end

    it "returns 'b' when 'c' is moved down by 1" do 
      cypher = Cypher.new
      expect(cypher.caesar_cipher('c',-1)).to eql('b')
    end

    it "returns '!' when '!' is entered and moved by any number up or down" do
      cypher = Cypher.new
      expect(cypher.caesar_cipher('!',20)).to eql('!')
    end

    it "returns 'Bmfy f xywnsl!' when 'What a string!' is moved up by 5" do 
      cypher = Cypher.new
      expect(cypher.caesar_cipher('What a string!',5)).to eql('Bmfy f xywnsl!')
    end
    
    it "returns 'CSAYZ' returns 'CSAYZ' when moved up by 0 and keeps case" do 
      cypher = Cypher.new
      expect(cypher.caesar_cipher('CSAYZ',0)).to eql('CSAYZ')
    end

    it "returns 'a' returns 'a' when moved by a float" do
      cypher = Cypher.new
      expect(cypher.caesar_cipher('a',0.0)).to eql('a')
    end

    it "returns '' when '' is moved by 5" do 
      cypher = Cypher.new
      expect(cypher.caesar_cipher('',0)).to eql('')
    end
  end
end
