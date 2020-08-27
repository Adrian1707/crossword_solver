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
    grid.map(&:join).select do |word|
      word.include?(word_to_check) || word.reverse.include?(word_to_check)
    end.any?
  end

  def word_in_diagonals?
    @diagonals = Set.new

    (0..grid.length).to_a.each_with_index do |_, column_index|
      @diagonals << check_diagonals_go_right_from_top(0, column_index)
    end

    (0..grid.length).to_a.each_with_index do |_, row_index|
      @diagonals << check_diagonals_go_down_from_top(row_index, 0)
    end

    (0..grid.length).to_a.each_with_index do |_, column_index|
      @diagonals << check_diagonals_go_right_from_bottom(0, column_index)
    end

    (0..grid.length).to_a.each_with_index do |_, row_index|
      @diagonals << check_diagonals_go_down_from_bottom(row_index, 0)
    end

    @diagonals.any? {|word| word.include?(word_to_check) || word.reverse.include?(word_to_check)}
  end

  def check_diagonals_go_right_from_top(row_index = 0, column_index = 0)
    return '' if column_index > grid.length - 1 || row_index > grid.length - 1
    joined_string = grid[row_index][column_index].dup
    joined_string << check_diagonals_go_right_from_top(row_index+1, column_index+1)
  end

  def check_diagonals_go_down_from_top(row_index = 0, column_index = 0)
    return '' if column_index > grid.length - 1 || row_index > grid.length - 1
    joined_string = grid[row_index][column_index].dup
    joined_string << check_diagonals_go_down_from_top(row_index+1, column_index+1)
  end

  def check_diagonals_go_right_from_bottom(row_index = 0, column_index = 0)
    return '' if column_index > grid.length - 1 || row_index > grid.length - 1
    joined_string = grid.reverse[row_index][column_index].dup
    joined_string << check_diagonals_go_right_from_bottom(row_index+1, column_index+1)
  end

  def check_diagonals_go_down_from_bottom(row_index = 0, column_index = 0)
    return '' if column_index > grid.length - 1 || row_index > grid.length - 1
    joined_string = grid.reverse[row_index][column_index].dup
    joined_string << check_diagonals_go_down_from_bottom(row_index+1, column_index+1)
  end
end
