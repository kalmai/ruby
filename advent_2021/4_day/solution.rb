# frozen_string_literal: true

require 'pry'

# Grid holds rows and columns
class Grid
  attr_accessor :rows, :columns

  def initialize(rows)
    @rows = process_rows(rows)
    @columns = create_columns
  end

  def create_columns
    rows.size.times.with_object([]) { |i, arr| arr.push(create_column(i)) }
  end

  def create_column(index)
    rows.each.with_object([]) do |row, arr|
      arr.push(row[index])
    end
  end

  def process_rows(rows)
    rows.map { |row| row.gsub('  ', ' ').strip.split(' ').map(&:to_i) }
  end
end

# Holds Grids, drawn_numbers, file_name, all_numbers, and determines first winner
class Bingo
  attr_accessor :drawn_numbers, :grids, :all_numbers, :file

  def initialize(file_name)
    @grids = []
    @drawn_numbers = []
    @file_name = file_name
    process_file
  end

  def process_grids
    File.readlines(@file_name)[2..].each.with_object([]) do |line, rows|
      rows.push(line.strip) unless line.strip.empty?
      if rows.size == 5
        grids.push(Grid.new(rows))
        rows.clear
      end
    end
  end

  def process_file
    @all_numbers = File.open(@file_name).readline.split(',').map(&:to_i)
    process_grids
  end

  def determine_winner
    grids.each do |grid|
      (grid.columns + grid.rows).one? do |nums|
        nums.delete(drawn_numbers.last)
        return announce_winner(grid) if nums.size.zero?
      end
    end
    nil
  end

  def play
    drawn_numbers.push(all_numbers.shift) while determine_winner.nil?
  end

  def announce_winner(grid)
    puts grid.columns.flatten.sum * drawn_numbers.last
    true
  end
end

Bingo.new('input.txt').play
