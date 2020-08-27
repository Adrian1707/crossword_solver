class Crossword
  attr_reader :word_to_check, :grid

  def initialize(grid, word_to_check)
    @grid = grid
    @word_to_check = word_to_check
  end

  def solve
    [
      word_in_rows_or_columns?(grid),
      word_in_rows_or_columns?(grid.transpose),
      word_in_diagonals?
    ].any? {|answer| answer == true}
  end

  def word_in_rows_or_columns?(grid)
    includes_word_to_check?(grid.map(&:join))
  end

  def word_in_diagonals?
    @diagonals = Set.new
    reverse_grid = grid.reverse
    (0..grid.length).to_a.each_with_index do |_, column_index|
      @diagonals << diagonal_strings(0, column_index, grid)
      @diagonals << diagonal_strings(0, column_index, reverse_grid)
    end

    (0..grid.length).to_a.each_with_index do |_, row_index|
      @diagonals << diagonal_strings(row_index, 0, grid)
      @diagonals << diagonal_strings(row_index, 0, reverse_grid)
    end

    includes_word_to_check?(@diagonals)
  end

  def includes_word_to_check?(collection)
    collection.any? {|word| word.include?(word_to_check) || word.reverse.include?(word_to_check)}
  end

  def diagonal_strings(row_index = 0, column_index = 0, grid)
    return '' if column_index > grid.length - 1 || row_index > grid.length - 1
    joined_string = grid[row_index][column_index].clone
    joined_string << diagonal_strings(row_index+1, column_index+1, grid)
  end
end
