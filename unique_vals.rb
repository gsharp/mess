# Author:  Glen Cuthbertson
# Date  :  11/11/2010
# Program Name: unique_vals.rb
#   - takes input from a file and creates a report on which unique ids have unique values
$usage = "USAGE: ruby unique_vals [-b] input_file \n"
abort "#{$usage}try: ruby unique_vals --help (for more info)" if ARGV.size <= 0
abort "-b     option will display bidder information for each auction\n--help opion dispays this message" if ARGV[0] == '--help'
$theFile = ARGV[0].index('-').nil? ? ARGV[0] : ARGV[1]


#*******************************class Aggr(fileName)*******************************
class Aggr
  #*******************************initialize()*******************************
  # in: takes filename from command line argument
  def initialize (fileName)
    @inputFile = fileName
  end

  #*******************************findUniqueLines(fileName)*******************************
  # proc: reads the csv file file and populates a global hash of deduped auctions and bidders
  def findUniqueLines
    hash = {}
    file = File.open(@inputFile, "r+")
    file.each do |line|
      line.chomp!
      lineArr = line.split(',')
      auct = lineArr[0]
      bidr = lineArr[1]
      # if auct doesn't exist we make it
      if hash[auct].nil? 
        hash[auct] = {bidr => 1} 
      # if bidr doesn't exist we make it
      elsif hash[auct][bidr].nil?
        hash[auct][bidr] = 1
      # add and iterate the existing auct / bidr
      else 
        hash[auct][bidr] += 1
      end
    end
    file.close
    return hash
  end
end # class Aggr


mess = Aggr.new $theFile
mess.findUniqueLines.each do |k,v| 
  puts "auction #{k} has #{v.size} unique bidders"
  v.each {|b,t| puts "  bidder #{b} bid #{t} times"} if ARGV[0] == '-b'
end