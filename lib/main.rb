txt_file = File.read('google-10000-english-no-swears.txt').split
  .select{ |word| word.length > 4}
  .select{ |word| word.length < 13}