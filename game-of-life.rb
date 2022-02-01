require_relative 'read.rb'
require_relative 'generation.rb'


# execute game of life algorithm based on the configuration information and start grid
# this execution ends when the number of the input generation is reached
def startGameOfLifeDefiniteTimes(configuration_information, grid)
    current_gen = configuration_information.generation_number
    while current_gen <= configuration_information.max_generation do
        grid = nextGeneration(grid, configuration_information.rows, configuration_information.columns)
        printGameOfLife(grid, configuration_information.rows, configuration_information.columns, current_gen)
        current_gen += 1
    end
end

# execute game of life algorithm based on the configuration information and start grid
# every generation has a delay of 1 sec
# this execution ends by an user explicit termination command
def startGameOfLifeTemporized(configuration_information, grid)
    current_gen = configuration_information.generation_number
    while true do
        grid = nextGeneration(grid, configuration_information.rows, configuration_information.columns)
        printGameOfLife(grid, configuration_information.rows, configuration_information.columns, current_gen)
        current_gen += 1
        sleep(1)
    end
end

# print 1 generation of game of life
def printGameOfLife(grid, rows, columns, current_gen)
    puts "Generation: #{current_gen}"
    puts "#{rows} #{columns}"
    grid.each{|row| puts row.join(" ")}
end


#reads initial configuration information, file path is passed as script first parameter
if(!ARGV[0])
    raise "You have to pass an input file!"
end
configuration_information = readFileConfigurationInfo(ARGV[0])

#reads initial state grid parse as array of arrays of chars (matrix m x n)
grid = readFileInitialStateGrid(ARGV[0])

# print the initial grid
puts "-- Initial State --"
grid.each{|row| puts row.join(" ")}


#read the max number of generation passed as script second parameter
if(!ARGV[1])
    # if there aren't specified the maximum number of generation
    # the Game of life does an iteration every second
    startGameOfLifeTemporized(configuration_information, grid)
else
    configuration_information.instance_variable_set(:@max_generation, ARGV[1].to_i)
    startGameOfLifeDefiniteTimes(configuration_information, grid)
end






