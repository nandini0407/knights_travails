require_relative "00_tree_node"

class KnightPathFinder
  DIFFS = [
    [-1, -2],
    [-2, -1],
    [1, -2],
    [2, -1],
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, 1]
  ]

  attr_reader :start, :grid, :visited_positions

  def self.valid_moves(pos)
    moves = DIFFS.map do |diff|
      x = (pos[0] + diff[0])
      y = (pos[1] + diff[1])
      next unless x.between?(0, 7) && y.between?(0, 7)
      [x, y]
    end
  end

  def initialize(start)
    @start = PolyTreeNode.new(start)
    @grid = Array.new(8) { Array.new(8) }
    @visited_positions = [start]
  end

  def build_move_tree
    q = [start]

    until q.empty?
      current_position = q.shift
      move_knight = new_move_positions(current_position.value)

      move_knight.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = current_position
        q << node
      end

      @visited_positions << current_position unless @visited_positions.include?(current_position)


    end

    @visited_positions
  end

  def find_path(final_)

  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves.reject { |x| x.nil? || @visited_positions.include?(x) }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  # def render
  #   p grid
  #   (0..7).each do |x|
  #     p line
  #   end
  # end
end

kpf = KnightPathFinder.new([5, 5])
p kpf.build_move_tree
