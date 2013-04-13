# LoadRunner

![alt text](http://my.stratos.net/~hewston95/RTM45/loderunner.png "Logo Title Text 1")

Take some Ruby Code and pass it to LoadRunner::Queue and you'll be able to
 * Run the code n number of times in parallel
 * Rand stagger the execution
 * Run the code threaded and staggered for a specific amount of time (ex. 5 minutes)

## Installation

Add this line to your application's Gemfile:

    gem 'load_runner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install load_runner

## Basic Usage

Create a LoadRunner Queue

    q = LoadRunner::Queue.new

pass a block of work for 4 threads
    
    q.load(4) do 
    	puts 'hi'
    end

run it

	q.run

## Ways to Run a Queue

Run parallel threads

    q.run

Run threads and stagger by rand number between 1-5
	
	q.run_and_stagger(5)

Run threads for 2 minutes

	q.run_for_duration(120)

Run threads for 2 minutes and stagger by rand number between 1-5

	q.run_for_duration(120, 5)


## Concurrency

To run the threads in a truely concurrent fashion across multiple processors you must:
 * Add LoadRunner Gem to your GemFile
 * Then set your project up to use JRuby. 

I use RBEnv so I run the following commands from the project folder:

 	rbenv install jruby-1.7.3
 	rbenv local jruby-1.7.3



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
