extends Node2D

var puzzle: Array
var font: DynamicFont
var padding := 30
var length := 450
var width := 10
var big_gap := round(length / 3.0)
var small_gap := round(big_gap / 3.0)

func _ready() -> void:
    randomize()
    puzzle = generate_puzzle()
    # Font is blurry but will do for now
    font = DynamicFont.new()
    font.font_data = preload("res://assets/fonts/FiraCode-Regular.ttf")
    font.size = 42
    font.use_filter = true

func _draw() -> void:
    draw_grid()
    draw_numbers()

func draw_grid() -> void:
    var colour := Color(0.65, 0.65, 0.65)
    var small_colour := colour.blend(Color.webgray)
    var chg: int
    
    # Draw inner box first so main box is displayed on top
    # Inner box rows
    for block in range(3):
        for num in range(1, 3):
            chg = padding + big_gap * block + small_gap * num
            draw_line(Vector2(padding, chg), Vector2(padding + length, chg), small_colour, width / 2)
    
    # Inner box cols
    for block in range(3):
        for num in range(1, 3):
            chg = padding + big_gap * block + small_gap * num
            draw_line(Vector2(chg, padding), Vector2(chg, padding + length), small_colour, width / 2)
    
    # Main box rows
    draw_line(Vector2(padding, padding + big_gap), Vector2(padding + length, padding + big_gap), colour, width)
    draw_line(Vector2(padding, padding + big_gap * 2), Vector2(padding + length, padding + big_gap * 2), colour, width)
    
    # Main box cols
    draw_line(Vector2(padding + big_gap, padding), Vector2(padding + big_gap, padding + length), colour, width)
    draw_line(Vector2(padding + big_gap * 2, padding), Vector2(padding + big_gap * 2, padding + length), colour, width)

func draw_numbers() -> void:
    var row_count: int
    var col_count: int
    var block_count := 0
    var row_start := 0
    
    for block in puzzle:
        row_count = row_start
        for row in block:
            col_count = 0 + block_count * 3
            for num in row:
                # TODO: Get proper center positioning
                # draw_char returns char width, maybe useful for positioning? idk
                draw_char(font, Vector2(padding * 1.35 + small_gap * col_count, padding * 2.35 + small_gap * row_count), str(num), "")
                col_count += 1
            row_count += 1
        block_count += 1
        
        if block_count >= 3:
            block_count = 0
            row_start += 3

func generate_puzzle() -> Array:
    # TODO: Return actual puzzle instead of dummy data
    return [[[1, 1, 1], [1, 1, 1], [1, 1, 1]], [[2, 2, 2], [2, 2, 2], [2, 2, 2]], [[3, 3, 3], [3, 3, 3], [3, 3, 3]], [[4, 4, 4], [4, 4, 4], [4, 4, 4]], [[5, 5, 5], [5, 5, 5], [5, 5, 5]], [[6, 6, 6], [6, 6, 6], [6, 6, 6]], [[7, 7, 7], [7, 7, 7], [7, 7, 7]], [[8, 8, 8], [8, 8, 8], [8, 8, 8]], [[9, 9, 9], [9, 9, 9], [9, 9, 9]]]

