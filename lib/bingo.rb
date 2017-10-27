require_relative './card'

class Bingo
  attr_reader :filename, :count, :rows, :columns

  def initialize(filename:, count:, rows:, columns:)
    @filename = filename
    @count = count
    @rows = rows
    @columns = columns
  end

  def generate!(open: false)
    Prawn::Document.generate(filename, **layout_options) do |pdf|
      pdf.font_families.update fonts
      pdf.font 'Rubik'

      count.times do |page|
        pdf.start_new_page if page > 1

        pdf.text 'FIND SOMEONE WHO…', style: :black, size: 24
        pdf.move_down 10

        pdf.bounding_box([0, pdf.cursor], width: pdf.bounds.width, height: pdf.cursor) do
          pdf.define_grid(rows: rows, columns: columns, gutter: 10)
          Card.new(rows: rows, columns: columns).boxes do |column, row, text|
            pdf.grid(row, column).bounding_box do
              pdf.stroke_bounds
              pdf.text_box(
                text,
                at: [10, pdf.bounds.height - 10],
                width: pdf.bounds.width - 20,
                height: pdf.bounds.height - 20,
                align: :center,
                valign: :center
              )
            end
          end
        end
      end
    end

    open_for_viewing if open
  end

  def open_for_viewing
    `open #{filename}`
  end

  private

  def layout_options
    { page_size: 'A4', page_layout: :landscape }
  end

  def fonts
    {
      'Rubik' => {
        normal: font_filename('Rubik-Light'),
        bold: font_filename('Rubik-Medium'),
        black: font_filename('Rubik-Black')
      }
    }
  end

  def font_filename(name)
    "#{File.dirname(__FILE__)}/../fonts/#{name}.ttf"
  end
end