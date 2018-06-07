class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

# NOTE: Guard about quality never negative? / quality never goes over 50 (except for "SULFURAS")
# days_remaining < 0 == quality goes down x 2
# "AGED BRIE" quality goes up!
# "SULFURAS" stays the same
# "BACKSTAGE PASSES" quality goes up / quality goes up x 2 WHEN <= 10 days / quality x 3 WHEN <= 5 / quality == 0 after the concert
# "CONJURED ITEM" degrade 2 x "NORMAL ITEM" speed
# "NORMAL ITEM"

  def tick
    case @name
    when "Normal Item"

    when "Aged Brie"
      @quality = compute_quality(+1, @days_remaining)
      @days_remaining = @days_remaining - 1
    when "Backstage passes to a TAFKAL80ETC concert"
      @quality = compute_quality(+1, @days_remaining)
      @days_remaining = @days_remaining - 1
    when "Conjured Mana Cake"
      @days_remaining = @days_remaining - 1
      @quality = compute_quality(-2, @days_remaining)
    else
      @quality_calculation
      @days_remaining
    end
  end

  def compute_quality(quality_calculation, days_remaining)
    if (@quality >= 0 && @quality <= 50) && @name != "Backstage passes to a TAFKAL80ETC concert"
      quality_calculation = days_remaining <= 0 ? quality_calculation * 2 : quality_calculation
      @quality = @quality + quality_calculation
      @quality = 0 if @quality <= 0
    else
      # I took the feedback from the pairing session, and I'm not going to worry about an alert
      # if things are less than 0. IRL I'd want to know how to handle edge cases (logging, error, etc.)
      # but it's a good call not to worry about that for now.
      return @quality = 0 if days_remaining <= 0
      quality_calculation = if (days_remaining >= 11)
                              quality_calculation * 1
                            elsif (days_remaining <= 10 && days_remaining >= 6)
                              quality_calculation * 2
                            else
                              quality_calculation * 3
                            end
      @quality = @quality + quality_calculation
    end
    @quality = @quality >= 50 ? 50 : @quality
  end




#     if @name != "Aged Brie" and @name != "Backstage passes to a TAFKAL80ETC concert"
#       if @quality > 0
#         if @name != "Sulfuras, Hand of Ragnaros"
#           @quality = (@name == 'Conjured Mana Cake') ? @quality - 2 : @quality - 1
#         end
#       end
#     else
#       if @quality < 50
#         @quality = @quality + 1
#         if @name == "Backstage passes to a TAFKAL80ETC concert"
#           if @days_remaining < 11
#             if @quality < 50
#               @quality = @quality + 1
#             end
#           end
#           if @days_remaining < 6
#             if @quality < 50
#               @quality = @quality + 1
#             end
#           end
#         end
#       end
#     end

#     if @name != "Sulfuras, Hand of Ragnaros"
#       @days_remaining = @days_remaining - 1
#     end

#     if @days_remaining < 0
#       if @name != "Aged Brie"
#         if @name != "Backstage passes to a TAFKAL80ETC concert"
#           if @quality > 0
#             if @name != "Sulfuras, Hand of Ragnaros"
#               @quality = (@name == 'Conjured Mana Cake') ? @quality - 2 : @quality - 1
#             end
#           end
#         else
#           @quality = @quality - @quality
#         end
#       else
#         if @quality < 50
#           @quality = @quality + 1
#         end
#       end
#     end
#   end
end
