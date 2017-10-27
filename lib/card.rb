class Card
  attr_reader :rows, :columns

  def initialize(rows: 4, columns: 4)
    @rows = rows
    @columns = columns
    @boxes = TARGETS.sample(rows * columns)
  end

  def boxes(&block)
    (0...rows).each do |row|
      (0...columns).each do |column|
        yield column, row, @boxes[row * rows + column]
      end
    end
  end

  private

  TARGETS = [
    '…has never written Ruby code for a job',
    '…used a pre-1.0 version of Rails',
    '…has a programming-related tattoo',
    '…has accidentally wiped production data',
    '…has had a pull request accepted to Rails core',
    '…maintains a gem with over 100K downloads',
    '…is a cat person',
    '…travelled from out of town for KiwiRuby',
    '…tutors at Rails Girls',
    '…is colourblind',
    '…works at Flux Federation',
    '…has been using Ruby for less than one year',
    '…does not have a Computer Science degree',
  ] * 2
end
