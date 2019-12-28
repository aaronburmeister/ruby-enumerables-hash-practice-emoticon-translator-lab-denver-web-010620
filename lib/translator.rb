# require modules here
require "yaml"
require "pp"

def load_library(file_path)
  library = YAML.load_file(file_path)
  database = {
    get_meaning: [],
    get_emoticon: []
  }
  library.each {|key, value| 
    database[:get_meaning] << {value.last => key.to_s}
    database[:get_emoticon] << {value.first.to_s => value.last.to_s}
  }
  database
end

def get_japanese_emoticon(file_path, english_emoticon)
  dictionary = load_library(file_path)
  result = nil
  dictionary[:get_emoticon].each {|emoticon| 
    if emoticon.has_key?(english_emoticon)
      result = emoticon.values
    end
  }
  if result == nil
    result = "Sorry, that emoticon was not found"
  end
  result
end

def get_english_meaning(file_path, japanese_emoticon)
  dictionary = load_library(file_path)
  result = nil
  dictionary[:get_meaning].each {|element|
    if element.has_key?(japanese_emoticon)
      result = element.values
    end
  }
  if !result
    result = "Sorry, that emoticon was not found"
  end
  result
end