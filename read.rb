
# Contains all the configuration information provided from input file
class ConfigurationInfo
    def initialize(generation_number, rows, columns)
        @generation_number = generation_number
        @rows = rows
        @columns = columns
        @max_generation = 0
    end

    def max_generation
        @max_generation
    end

    def generation_number
        @generation_number
    end

    def rows
        @rows
    end

    def columns
        @columns
    end
end

#read input configuration information from the file specified by the path
#return a ConfigurationInfo data with those information
def readFileConfigurationInfo(path)
    file = File.open(path, "r")
    file_data = file.readlines.map(&:chomp)

    #in the read data knows the exact position of the main information:
    #generation number in the first line
    generation_number_extracted = file_data[0].scan(/\d+/).map(&:to_i)

    # number of rows and columns in the second line
    size_extracted = file_data[1].scan(/\d+/).map(&:to_i)

    # generation_number, nr_rows, nr_columns
    configuration_info = ConfigurationInfo.new(generation_number_extracted[0], size_extracted[0],
        size_extracted[1])
    file.close
    return configuration_info
end

#read input population state from the file specified by the path
#return an array of strings where each string represents a row of the grid
def readFileInitialStateGrid(path)
    file = File.open(path, "r")
    lines = []
    #start to read the grid state from the 3 line of the file
    file.each_line.each_with_index { |val,index| lines.push(val) if index > 1}

    #remove break line character
    lines.each{|line| line.delete!("\n")}

    #replace every row, reads as string, with  a char array
    lines = lines.map{|line| line = line.chars}

    file.close

    return lines
end


