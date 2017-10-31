class Card
  attr_reader :rows, :columns

  def initialize(rows: 4, columns: 4, categories:)
    @rows = rows
    @columns = columns
    @boxes = categories.sample(rows * columns)
  end

  def boxes(&block)
    (0...rows).each do |row|
      (0...columns).each do |column|
        yield column, row, '…' + @boxes[row * rows + column]
      end
    end
  end
end
