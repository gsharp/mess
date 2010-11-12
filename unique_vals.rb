# Author:  Glen Cuthbertson
# Date  :  11/11/2010
# Program Name: unique_vals.rb
#   - takes input from a file and creates a report on which unique ids have unique values

abort "USAGE: ruby unique_vals input_file" if ARGV.size <= 0

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
      hash[auct].nil? ? hash[auct] = {bidr => 1} : hash[auct][bidr] = 1
    end
    file.close
    return hash
  end
end # class Aggr

mess = Aggr.new ARGV[0]
mess.findUniqueLines.each {|k,v| puts "auction #{k} has #{v.size} unique bidders"}