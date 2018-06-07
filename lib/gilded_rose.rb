class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    case name
    when 'Normal Item'
      @quality = compute_quality(-1, @days_remaining)
    when 'Aged Brie', 'Backstage passes to a TAFKAL80ETC concert'
      @quality = compute_quality(+1, @days_remaining)
    when 'Conjured Mana Cake'
      @quality = compute_quality(-2, @days_remaining)
    else
      @quality
      @days_remaining
    end
    @days_remaining = @days_remaining - 1 unless name == 'Sulfuras, Hand of Ragnaros'
  end

  def compute_quality(quality_calculation, days_remaining)
    if (@quality >= 0 && @quality <= 50) && name != 'Backstage passes to a TAFKAL80ETC concert'
      quality_calculation = days_remaining <= 0 ? quality_calculation * 2 : quality_calculation
      @quality = @quality + quality_calculation
      @quality = 0 if @quality <= 0
    else
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
end
