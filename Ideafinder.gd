extends Control

onready var sentence := $CenterContainer/VBoxContainer/HBoxContainer/Sentence
onready var words : PopupMenu = $CenterContainer/VBoxContainer/HBoxContainer2/MenuButton.get_popup()
onready var result := $CenterContainer/VBoxContainer/Result

func _ready() -> void:
	for word in Content.words:
		words.add_item(word)
	words.connect("id_pressed", self, "_word_pressed")
	_on_Generate_pressed()
	randomize()


func rand_word(word : String) -> String:
	
	return Content.words[word][randi() % Content.words[word].size()]


func replace(string : String, what : String, forwhat : String) -> String:
	var p = string.find(what)
	if p == 0:
		return forwhat + string.right(what.length())
	return string.substr(0, p) + forwhat + string.substr(p + what.length())


func generate(line : String) -> String:
	var result := line
	for word in Content.words:
		print(word)
		var pos = result.find(word)
		while pos != -1:
			result = replace(result, word, rand_word(word))
			pos = result.find(word)
	return result


func _word_pressed(id : int) -> void:
	sentence.insert_text_at_cursor(words.get_item_text(id))
	pass


func _on_Generate_pressed():
	result.text = generate(sentence.text)
	pass
