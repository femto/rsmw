class CScore
  attr_accessor :score, :x,:y,:destx,:desty,:place
  attr_accessor :fromx,:fromy,:displayorder,:order
  attr_accessor :iDigitLeft,:iDigitMiddle,:iDigitRight
  def initialize(iPlace)
    @place = iPlace;
    @displayorder = iPlace;
		@score = 0;
		@x = 0;
		@y = 0;
		@destx = 0;
		@desty = 0;
		@order = 0;
		@fromx = 0;
		@fromy = 0;
		@iDigitRight = 0;
		@iDigitMiddle = 0;
		@iDigitLeft = 0;
  end   
  def setScore(iValue)
    @score = iValue;
		setDigitCounters();
  end  
  
  def adjustScore(iValue)
		@score += iValue;

		if(@score < 0)
			@score = 0;
		end
		
		puts "score now is #@score"

		setDigitCounters();
 end
 def setDigitCounters
   iDigits = @score
   while(iDigits > 999)
			iDigits -= 1000;
	 end
	 @iDigitLeft = iDigits / 100 * 16;
	 @iDigitMiddle = iDigits % 100 / 10 * 16;
	 @iDigitRight = iDigits % 10 * 16;
	 puts "iDigits now is #{iDigits}"
 end
end     